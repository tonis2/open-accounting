import 'package:file_picker/file_picker.dart';
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
import '../../theme.dart';
import 'connection_status.dart';
import 'edit_connection_dialog.dart';
import 'explain_form.dart';

class AccountPage extends StatefulWidget {
  final String accountId;
  const AccountPage({super.key, required this.accountId});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  BankAccount? _account;
  List<BankAccount> _accounts = [];
  List<BankConnection> _connections = [];
  List<BankProvider> _providers = [];
  List<Category> _categories = [];
  ListTransactionsResponse? _txs;
  int _tab = 0;
  String _month = '';
  String _search = '';
  int _page = 1;
  static const _pageSize = 50;
  Int64? _expanded;
  final Set<Int64> _selected = {};
  bool _loading = true;
  bool _uploading = false;
  Int64 _companyId = Int64.ZERO;

  Int64 get _accountId => Int64.parseInt(widget.accountId);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = Inherited.of(context).companyId;
    if (id != _companyId) {
      _companyId = id;
      final tab = GoRouterState.of(context).uri.queryParameters['tab'];
      if (tab == 'approval') _tab = 2;
      _loadAll();
    }
  }

  Future<void> _loadAll() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      final results = await Future.wait([
        state.server.listBankAccounts(CompanyRequest(companyId: _companyId)),
        state.server.listCategories(CompanyRequest(companyId: _companyId)),
        state.server.listBankConnections(CompanyRequest(companyId: _companyId)),
        state.server.listBankProviders(Empty()),
      ]);
      _accounts = (results[0] as ListBankAccountsResponse).items;
      _account = _accounts.where((a) => a.id == _accountId).firstOrNull;
      _categories = (results[1] as ListCategoriesResponse).items;
      _connections = (results[2] as ListBankConnectionsResponse).items;
      logConnectionIssues(_connections);
      _providers = (results[3] as ListBankProvidersResponse).items;
      await _loadTransactions();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  TransactionStatus get _statusFilter => switch (_tab) {
    1 => TransactionStatus.TRANSACTION_STATUS_UNEXPLAINED,
    2 => TransactionStatus.TRANSACTION_STATUS_EXPLAINED,
    3 => TransactionStatus.TRANSACTION_STATUS_APPROVED,
    _ => TransactionStatus.TRANSACTION_STATUS_UNSPECIFIED,
  };

  Future<void> _loadTransactions() async {
    final state = Inherited.read(context);
    final res = await state.server.listTransactions(
      ListTransactionsRequest(
        companyId: _companyId,
        accountId: _accountId,
        status: _statusFilter,
        month: _month,
        search: _search,
        page: _page,
        pageSize: _pageSize,
      ),
    );
    if (mounted) setState(() => _txs = res);
  }

  Future<void> _refreshAccount() async {
    final state = Inherited.read(context);
    final res = await state.server.listBankAccounts(CompanyRequest(companyId: _companyId));
    if (mounted) {
      setState(() {
        _accounts = res.items;
        _account = res.items.where((a) => a.id == _accountId).firstOrNull;
      });
    }
  }

  void _reload() {
    _page = 1;
    _loadTransactions();
  }

  Future<void> _uploadStatement() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    final result = await FilePicker.pickFiles(withData: true, type: FileType.custom, allowedExtensions: ['csv', 'txt']);
    final file = result?.files.firstOrNull;
    if (file?.bytes == null) return;
    setState(() => _uploading = true);
    try {
      final res = await state.server.uploadStatement(
        UploadStatementRequest(companyId: _companyId, accountId: _accountId, filename: file!.name, data: file.bytes),
      );
      final msg = l.statementImported(res.imported, res.duplicates, res.skipped);
      AppLogger.info(res.invoicesMatched > 0 ? '$msg · ${l.statementMatched(res.invoicesMatched)}' : msg);
      for (final w in res.warnings) {
        AppLogger.debug('statement: $w');
      }
      await _loadTransactions();
      await _refreshAccount();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _approveSelected() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      await state.server.approveTransactions(ApproveTransactionsRequest(companyId: _companyId, ids: _selected.toList()));
      AppLogger.info(l.transactionApproved(_selected.length));
      _selected.clear();
      await _loadTransactions();
      await _refreshAccount();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  List<String> _monthOptions() {
    final now = DateTime.now();
    return [for (var i = 0; i < 18; i++) monthKey(DateTime(now.year, now.month - i))];
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final wide = MediaQuery.sizeOf(context).width >= 1200;
    final account = _account;
    if (_loading) return const SkeletonLines(lines: 8);
    if (account == null) {
      return EmptyState(
        icon: Icons.account_balance_outlined,
        title: l.noResults,
        subtitle: '',
        buttonLabel: l.backToBanking,
        onButtonPressed: () => context.go(AppRoutes.banking),
      );
    }

    final main = _transactionsPanel(context, l, account);
    final side = _sidebar(context, l, account);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go(AppRoutes.banking)),
          title: account.name,
          subtitle: [account.iban, account.currency].where((s) => s.isNotEmpty).join(' · '),
          actions: [
            if (_accounts.length > 1)
              HeaderDropdown<Int64>(
                value: account.id,
                items: [for (final a in _accounts) DropdownMenuItem(value: a.id, child: Text(a.name))],
                onChanged: (v) => v == null ? null : context.go('${AppRoutes.bankAccount}/$v'),
              ),
            if (_selected.isNotEmpty) ElevatedButton(onPressed: _approveSelected, child: Text('${l.transactionApproveSelected} (${_selected.length})')),
            Tooltip(
              message: l.uploadStatementHint,
              child: BusyButton(
                busy: _uploading,
                outlined: true,
                onPressed: _uploadStatement,
                child: Row(mainAxisSize: MainAxisSize.min, spacing: 6, children: [const Icon(Icons.upload_file, size: 18), Text(l.uploadStatement)]),
              ),
            ),
          ],
        ),
        if (wide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Expanded(flex: 3, child: main),
              SizedBox(width: 300, child: side),
            ],
          )
        else
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 20, children: [main, side]),
      ],
    );
  }

  Widget _transactionsPanel(BuildContext context, AppLocalizations l, BankAccount account) {
    final theme = Theme.of(context);
    final txs = _txs;
    final tabs = [
      l.transactionsAll,
      l.transactionsUnexplained,
      '${l.transactionsForApproval}${account.forApprovalCount > 0 ? ' (${account.forApprovalCount})' : ''}',
      l.transactionsApproved,
    ];
    final compact = !isDesktop(context);

    return PanelCard(
      tabs: tabs,
      tabIndex: _tab,
      onTab: (i) {
        setState(() {
          _tab = i;
          _expanded = null;
          _selected.clear();
        });
        _reload();
      },
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.spaceBetween,
              children: [
                HeaderDropdown<String>(
                  value: _month,
                  items: [
                    DropdownMenuItem(value: '', child: Text(l.allMonths)),
                    for (final m in _monthOptions()) DropdownMenuItem(value: m, child: Text(formatMonthKey(m, withYear: true))),
                  ],
                  onChanged: (v) {
                    setState(() => _month = v ?? '');
                    _reload();
                  },
                ),
                AppSearchBar(
                  hintText: l.searchHint,
                  width: 320,
                  onSubmitted: (v) {
                    setState(() => _search = v);
                    _reload();
                  },
                ),
              ],
            ),
          ),
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: theme.dividerColor),
                bottom: BorderSide(color: theme.dividerColor),
              ),
            ),
            child: Row(
              spacing: 12,
              children: [
                const SizedBox(width: 24),
                SizedBox(width: 84, child: Text(l.transactionDate, style: theme.textTheme.titleSmall)),
                Expanded(child: Text(l.transactionDescription, style: theme.textTheme.titleSmall)),
                SizedBox(
                  width: 100,
                  child: Text(l.transactionMoneyIn, style: theme.textTheme.titleSmall, textAlign: TextAlign.right),
                ),
                SizedBox(
                  width: 100,
                  child: Text(l.transactionMoneyOut, style: theme.textTheme.titleSmall, textAlign: TextAlign.right),
                ),
                if (!compact)
                  SizedBox(
                    width: 110,
                    child: Text(l.transactionBalance, style: theme.textTheme.titleSmall, textAlign: TextAlign.right),
                  ),
              ],
            ),
          ),
          if (txs == null)
            const SkeletonLines()
          else if (txs.items.isEmpty)
            EmptyState(icon: Icons.receipt_long_outlined, title: l.noTransactionsTitle, subtitle: l.noTransactionsBody)
          else ...[
            if (_month.isNotEmpty && !compact)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 120),
                    Expanded(
                      child: Text(l.balanceBroughtForward, style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(
                      width: 110,
                      child: Text(
                        formatMoney(txs.balanceBroughtForwardCents, currency: account.currency),
                        textAlign: TextAlign.right,
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            for (final t in txs.items) _row(context, l, t, account, compact),
            if (txs.total > _pageSize)
              TablePager(
                page: _page,
                pageSize: _pageSize,
                total: txs.total,
                label: (p, n) => l.pageOf(p, n),
                onPage: (p) {
                  setState(() => _page = p);
                  _loadTransactions();
                },
              ),
          ],
        ],
      ),
    );
  }

  Widget _row(BuildContext context, AppLocalizations l, Transaction t, BankAccount account, bool compact) {
    final theme = Theme.of(context);
    final expanded = _expanded == t.id;
    final unexplained = t.status == TransactionStatus.TRANSACTION_STATUS_UNEXPLAINED;
    final titleColor = unexplained
        ? AppColors.danger
        : (t.status == TransactionStatus.TRANSACTION_STATUS_EXPLAINED ? AppColors.warning : theme.colorScheme.onSurface);
    final title = t.counterpartyName.isNotEmpty ? t.counterpartyName : t.description;
    final subtitle = [t.description != title ? t.description : '', t.reference].where((s) => s.isNotEmpty).join(' /// ');

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = expanded ? null : t.id),
          hoverColor: theme.colorScheme.surfaceContainerLow,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: expanded ? Colors.transparent : theme.colorScheme.outlineVariant)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(
                  width: 24,
                  height: 20,
                  child: t.status == TransactionStatus.TRANSACTION_STATUS_EXPLAINED
                      ? Checkbox(value: _selected.contains(t.id), onChanged: (v) => setState(() => v == true ? _selected.add(t.id) : _selected.remove(t.id)))
                      : null,
                ),
                SizedBox(width: 84, child: Text(formatTimestamp(t.bookedAt), style: theme.textTheme.bodyMedium)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: title,
                              style: theme.textTheme.bodyMedium?.copyWith(color: titleColor, fontWeight: FontWeight.w700),
                            ),
                            if (t.categoryName.isNotEmpty)
                              TextSpan(
                                text: '  ${t.categoryName}',
                                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface),
                              ),
                            if (t.invoiceNumber.isNotEmpty)
                              TextSpan(
                                text: '  ${l.transactionLinkedInvoice(t.invoiceNumber)}',
                                style: theme.textTheme.bodySmall?.copyWith(color: AppColors.success),
                              ),
                          ],
                        ),
                      ),
                      if (subtitle.isNotEmpty) Text(subtitle, style: theme.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Row(
                        spacing: 8,
                        children: [
                          if (t.attachmentCount > 0) Icon(Icons.attach_file, size: 14, color: theme.hintColor),
                          if (t.note.isNotEmpty) Icon(Icons.notes, size: 14, color: theme.hintColor),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: t.amountCents > Int64.ZERO
                      ? Text(formatMoney(t.amountCents), textAlign: TextAlign.right, style: theme.textTheme.bodyMedium)
                      : const SizedBox.shrink(),
                ),
                SizedBox(
                  width: 100,
                  child: t.amountCents < Int64.ZERO
                      ? Text(formatMoney(-t.amountCents), textAlign: TextAlign.right, style: theme.textTheme.bodyMedium)
                      : const SizedBox.shrink(),
                ),
                if (!compact)
                  SizedBox(
                    width: 110,
                    child: Text(
                      formatMoney(t.runningBalanceCents),
                      textAlign: TextAlign.right,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (expanded)
          ExplainForm(
            transaction: t,
            categories: _categories,
            onSaved: (updated) async {
              setState(() => _expanded = null);
              await _loadTransactions();
              await _refreshAccount();
            },
            onCancel: () => setState(() => _expanded = null),
          ),
      ],
    );
  }

  Widget _sidebar(BuildContext context, AppLocalizations l, BankAccount account) {
    final theme = Theme.of(context);
    final byCategory = <String, int>{};
    for (final t in _txs?.items ?? <Transaction>[]) {
      if (t.status == TransactionStatus.TRANSACTION_STATUS_EXPLAINED) byCategory[t.categoryName] = (byCategory[t.categoryName] ?? 0) + 1;
    }
    final needsUpdate =
        account.connectionStatus == ConnectionStatus.CONNECTION_STATUS_EXPIRED || account.connectionStatus == ConnectionStatus.CONNECTION_STATUS_ERROR;
    final conn = _connections.where((c) => c.id == account.connectionId).firstOrNull;
    final provider = _providers.where((p) => p.id == conn?.provider).firstOrNull;

    return Column(
      spacing: 20,
      children: [
        PanelCard(
          title: l.bankFeed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              StatusBadge(
                label: connectionLabel(l, account.connectionStatus, account.consentExpiresAt),
                tone: connectionTone(account.connectionStatus, account.consentExpiresAt),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.feedLastImport, style: theme.textTheme.bodySmall),
                  Text(
                    account.hasLastSyncAt() ? formatDateTime(account.lastSyncAt) : l.feedNeverSynced,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              if (conn?.statementsOnly == true && !needsUpdate) ...[
                Text(
                  conn!.statusMessage.isNotEmpty ? conn.statusMessage : (conn.provider == 'wise' ? l.statementsOnlyWise : l.statementsOnlyInfo),
                  style: theme.textTheme.bodySmall,
                ),
                OutlinedButton.icon(onPressed: _uploadStatement, icon: const Icon(Icons.upload_file, size: 18), label: Text(l.uploadStatement)),
              ],
              if (needsUpdate) ...[
                // Show the provider's own error so the fix is obvious (e.g. a missing Wise key).
                Text(
                  (conn?.statusMessage ?? '').isNotEmpty ? conn!.statusMessage : l.updateConnectionBody,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (conn != null && provider != null)
                      ElevatedButton(
                        onPressed: () async {
                          final updated = await EditConnectionDialog.show(context, connection: conn, provider: provider);
                          if (updated != null) _loadAll();
                        },
                        child: Text(l.editConnection),
                      ),
                    OutlinedButton(onPressed: () => context.go(AppRoutes.banking), child: Text(l.updateConnection)),
                  ],
                ),
              ],
            ],
          ),
        ),
        PanelCard(
          title: l.forApproval,
          child: byCategory.isEmpty
              ? Text(l.noResults, style: theme.textTheme.bodySmall)
              : Column(
                  spacing: 8,
                  children: [
                    for (final e in byCategory.entries)
                      Row(
                        children: [
                          Expanded(child: LinkText(e.key.isEmpty ? l.unexplained : e.key, bold: false)),
                          CountBadge(count: e.value, tone: BadgeTone.neutral),
                        ],
                      ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(l.totalForApproval, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                        ),
                        CountBadge(count: account.forApprovalCount),
                      ],
                    ),
                  ],
                ),
        ),
        PanelCard(
          title: l.bankDetails,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                spacing: 12,
                children: [
                  Icon(Icons.account_balance, color: theme.colorScheme.primary, size: 28),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.totalBalance, style: theme.textTheme.bodySmall),
                      Text(formatMoney(account.balanceCents, currency: account.currency), style: theme.textTheme.titleLarge),
                    ],
                  ),
                ],
              ),
              _kv(theme, l.bank, account.connectionName),
              if (account.iban.isNotEmpty) _kv(theme, l.iban, account.iban),
              _kv(theme, l.currency, account.currency),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kv(ThemeData theme, String k, String v) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(k, style: theme.textTheme.bodySmall),
      Text(v, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
    ],
  );
}
