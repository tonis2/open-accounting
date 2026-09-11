import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../responsive.dart';
import '../../services/errors.dart';
import '../../services/format.dart';
import '../../state.dart';
import 'connection_status.dart';
import 'edit_connection_dialog.dart';

class BankingPage extends StatefulWidget {
  const BankingPage({super.key});

  @override
  State<BankingPage> createState() => _BankingPageState();
}

class _BankingPageState extends State<BankingPage> {
  List<BankAccount> _accounts = [];
  List<BankConnection> _connections = [];
  List<BankProvider> _providers = [];
  BalanceHistoryResponse? _history;
  Int64 _selected = Int64.ZERO;
  bool _loading = true;
  bool _syncing = false;
  Int64 _companyId = Int64.ZERO;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = Inherited.of(context).companyId;
    if (id != _companyId) {
      _companyId = id;
      _load();
    }
  }

  Future<void> _load() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      final results = await Future.wait([
        state.server.listBankAccounts(CompanyRequest(companyId: _companyId)),
        state.server.listBankConnections(CompanyRequest(companyId: _companyId)),
        state.server.getBalanceHistory(BalanceHistoryRequest(companyId: _companyId, accountId: _selected, months: 12)),
        state.server.listBankProviders(Empty()),
      ]);
      if (!mounted) return;
      setState(() {
        _accounts = (results[0] as ListBankAccountsResponse).items;
        _connections = (results[1] as ListBankConnectionsResponse).items;
        logConnectionIssues(_connections);
        _history = results[2] as BalanceHistoryResponse;
        _providers = (results[3] as ListBankProvidersResponse).items;
        _loading = false;
      });
    } catch (e) {
      if (mounted) setState(() => _loading = false);
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  Future<void> _sync() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    setState(() => _syncing = true);
    try {
      final res = await state.server.syncNow(CompanyRequest(companyId: _companyId));
      if (res.errors.isNotEmpty) {
        AppLogger.warning(res.errors.join('\n'));
      } else {
        AppLogger.info(l.syncDone(res.connectionsSynced, res.transactionsAdded, res.invoicesMatched));
      }
      await _load();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.syncFailed), error: e);
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  Future<void> _reconnect(BankConnection c) async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      final res = await state.server.reconnectBankConnection(CompanyIdRequest(companyId: _companyId, id: c.id));
      if (res.redirectUrl.isNotEmpty) {
        openExternal(res.redirectUrl);
      } else {
        AppLogger.info(l.connectBankConnected);
        _load();
      }
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.connectBankFailed), error: e);
    }
  }

  Future<void> _editConnection(BankConnection c) async {
    final provider = _providers.where((p) => p.id == c.provider).firstOrNull;
    if (provider == null) return;
    final updated = await EditConnectionDialog.show(context, connection: c, provider: provider);
    if (updated != null) _load();
  }

  Future<void> _remove(BankConnection c) async {
    final l = AppLocalizations.of(context)!;
    final ok = await confirmDialog(
      context,
      title: l.removeConnection,
      message: l.removeConnectionConfirm(c.name),
      confirmLabel: l.remove,
      cancelLabel: l.cancel,
      destructive: true,
    );
    if (!ok || !mounted) return;
    final state = Inherited.read(context);
    try {
      await state.server.deleteBankConnection(CompanyIdRequest(companyId: _companyId, id: c.id));
      AppLogger.info(l.connectionRemoved);
      _load();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  Future<void> _setPrimary(BankAccount a) async {
    final state = Inherited.read(context);
    await state.server.setPrimaryAccount(CompanyIdRequest(companyId: _companyId, id: a.id));
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final wide = isDesktop(context);
    final cur = Inherited.of(context).activeCompany?.currency ?? '';
    final needsAttention = _connections.any(
      (c) => c.status == ConnectionStatus.CONNECTION_STATUS_EXPIRED || c.status == ConnectionStatus.CONNECTION_STATUS_ERROR,
    );
    final totalBalance = _accounts.where((a) => a.currency == cur).fold<Int64>(Int64.ZERO, (s, a) => s + a.balanceCents);
    final forApproval = _accounts.fold<int>(0, (s, a) => s + a.forApprovalCount);
    final unexplained = _accounts.fold<int>(0, (s, a) => s + a.unexplainedCount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: l.bankingTitle,
          actions: [
            if (_connections.isNotEmpty)
              BusyButton(
                busy: _syncing,
                outlined: true,
                onPressed: _sync,
                child: Row(mainAxisSize: MainAxisSize.min, spacing: 6, children: [const Icon(Icons.sync, size: 18), Text(l.syncNow)]),
              ),
            ElevatedButton(onPressed: () => context.go(AppRoutes.bankConnect), child: Text(l.addNewAccount)),
          ],
        ),
        if (needsAttention)
          AlertBanner(
            title: l.bankConnectionNeedsAttention,
            message: l.bankConnectionNeedsAttentionBody,
            actionLabel: l.manageBankConnections,
            onAction: () {},
          ),
        if (_loading)
          const PanelCard(child: SkeletonLines(lines: 6))
        else if (_accounts.isEmpty)
          PanelCard(
            child: EmptyState(
              icon: Icons.account_balance_outlined,
              title: l.noBankAccountsTitle,
              subtitle: l.noBankAccountsBody,
              buttonLabel: l.connectBank,
              onButtonPressed: () => context.go(AppRoutes.bankConnect),
            ),
          )
        else ...[
          PanelCard(
            padding: EdgeInsets.zero,
            trailing: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(l.monthlyBalances, style: theme.textTheme.bodySmall),
            ),
            title: '',
            child: _MaybeIntrinsic(
              enabled: wide,
              child: Flex(
                direction: wide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: wide ? 1 : 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          HeaderDropdown<Int64>(
                            value: _selected,
                            items: [
                              DropdownMenuItem(value: Int64.ZERO, child: Text(l.allAccounts)),
                              for (final a in _accounts) DropdownMenuItem(value: a.id, child: Text(a.name)),
                            ],
                            onChanged: (v) {
                              setState(() => _selected = v ?? Int64.ZERO);
                              _load();
                            },
                          ),
                          LineChartPanel(
                            currency: cur,
                            labels: [for (final p in _history?.points ?? []) formatMonthKey(p.month)],
                            values: [for (final p in _history?.points ?? []) p.balanceCents.toInt()],
                            height: 220,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (wide) Container(width: 1, color: theme.dividerColor) else const Divider(),
                  SizedBox(
                    width: wide ? 260 : null,
                    child: StatColumn(
                      tiles: [
                        StatTile(
                          label: l.totalBalance,
                          value: formatMoney(totalBalance, currency: cur),
                        ),
                        StatTile(label: l.totalForApproval, value: '$forApproval', tone: forApproval > 0 ? StatTone.warning : StatTone.neutral),
                        StatTile(label: l.totalUnexplained, value: '$unexplained', tone: unexplained > 0 ? StatTone.negative : StatTone.neutral),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PanelCard(
            title: l.bankAccounts,
            padding: EdgeInsets.zero,
            child: CustomTable(
              bordered: false,
              columns: [
                TableColumn(header: l.accountDetails, size: const FlexColumn(4)),
                if (wide) TableColumn(header: l.bankFeed, size: const FlexColumn(3)),
                TableColumn(header: l.forApproval, size: const FlexColumn(2), align: TextAlign.right),
                if (wide) TableColumn(header: l.unexplained, size: const FlexColumn(2), align: TextAlign.right),
                TableColumn(header: l.accountBalance, size: const FlexColumn(3), align: TextAlign.right),
                const TableColumn(header: '', size: FixedColumn(48)),
              ],
              itemCount: _accounts.length,
              onRowTap: (i) => context.go('${AppRoutes.bankAccount}/${_accounts[i].id}'),
              rowBuilder: (i) {
                final a = _accounts[i];
                final conn = _connections.where((c) => c.id == a.connectionId).firstOrNull;
                return [
                  Row(
                    spacing: 12,
                    children: [
                      Icon(Icons.account_balance, color: theme.colorScheme.primary),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 6,
                              children: [
                                Flexible(child: LinkText(a.name, onTap: () => context.go('${AppRoutes.bankAccount}/${a.id}'))),
                                if (a.isPrimary)
                                  Tooltip(
                                    message: l.primaryAccount,
                                    child: Icon(Icons.star, size: 16, color: theme.colorScheme.onSurfaceVariant),
                                  ),
                              ],
                            ),
                            Text(a.iban.isNotEmpty ? a.iban : '${a.connectionName} · ${a.currency}', style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (wide)
                    connectionStatusColumn(
                      context,
                      a.connectionStatus,
                      a.consentExpiresAt,
                      a.lastSyncAt,
                      message: conn?.statusMessage ?? '',
                      statementsOnly: conn?.statementsOnly ?? false,
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${a.forApprovalCount}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: a.forApprovalCount > 0 ? const Color(0xFFE0851A) : null,
                        ),
                      ),
                      if (a.forApprovalCount > 0)
                        LinkText(l.approveTransactions, bold: false, onTap: () => context.go('${AppRoutes.bankAccount}/${a.id}?tab=approval')),
                    ],
                  ),
                  if (wide)
                    Text(
                      '${a.unexplainedCount}',
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: a.unexplainedCount > 0 ? theme.colorScheme.error : null),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatMoney(a.balanceCents, currency: a.currency),
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (a.hasBalanceAt()) Text(l.balanceOn(formatTimestamp(a.balanceAt)), style: theme.textTheme.bodySmall),
                    ],
                  ),
                  PopupMenuButton<String>(
                    tooltip: '',
                    icon: const Icon(Icons.more_vert, size: 18),
                    onSelected: (v) {
                      if (v == 'primary') _setPrimary(a);
                      if (v == 'edit' && conn != null) _editConnection(conn);
                      if (v == 'reconnect' && conn != null) _reconnect(conn);
                      if (v == 'remove' && conn != null) _remove(conn);
                    },
                    itemBuilder: (_) => [
                      if (!a.isPrimary) PopupMenuItem(value: 'primary', child: Text(l.setAsPrimary)),
                      PopupMenuItem(value: 'edit', child: Text(l.editConnection)),
                      PopupMenuItem(value: 'reconnect', child: Text(l.updateConnection)),
                      PopupMenuItem(value: 'remove', child: Text(l.removeConnection)),
                    ],
                  ),
                ];
              },
            ),
          ),
          Row(
            spacing: 6,
            children: [
              Icon(Icons.star_outline, size: 16, color: theme.hintColor),
              Text(l.primaryAccount, style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ],
    );
  }
}

/// Rows that stretch their children need a bounded height inside a scrolling column.
class _MaybeIntrinsic extends StatelessWidget {
  final bool enabled;
  final Widget child;
  const _MaybeIntrinsic({required this.enabled, required this.child});

  @override
  Widget build(BuildContext context) => enabled ? IntrinsicHeight(child: child) : child;
}
