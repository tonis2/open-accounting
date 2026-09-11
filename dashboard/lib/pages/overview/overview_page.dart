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

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  OverviewResponse? _data;
  List<BankAccount> _accounts = [];
  List<Transaction> _recent = [];
  BalanceHistoryResponse? _accountHistory;
  Int64 _companyId = Int64.ZERO;
  int _months = 12;
  Int64 _selectedAccount = Int64.ZERO;
  int _invoiceTab = 0;
  int _bottomTab = 0;
  bool _loading = true;

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
    if (_companyId == Int64.ZERO) return;
    setState(() => _loading = true);
    try {
      final results = await Future.wait([
        state.server.getOverview(OverviewRequest(companyId: _companyId, months: _months)),
        state.server.listBankAccounts(CompanyRequest(companyId: _companyId)),
        state.server.listTransactions(ListTransactionsRequest(companyId: _companyId, pageSize: 6)),
      ]);
      if (!mounted) return;
      setState(() {
        _data = results[0] as OverviewResponse;
        _accounts = (results[1] as ListBankAccountsResponse).items;
        _recent = (results[2] as ListTransactionsResponse).items;
        _accountHistory = null;
        _loading = false;
      });
    } catch (e) {
      if (mounted) setState(() => _loading = false);
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  Future<void> _loadAccountHistory(Int64 accountId) async {
    final state = Inherited.read(context);
    setState(() => _selectedAccount = accountId);
    if (accountId == Int64.ZERO) {
      setState(() => _accountHistory = null);
      return;
    }
    try {
      final res = await state.server.getBalanceHistory(BalanceHistoryRequest(companyId: _companyId, accountId: accountId, months: _months));
      if (mounted) setState(() => _accountHistory = res);
    } catch (e) {
      AppLogger.debug('balance history failed', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final wide = MediaQuery.sizeOf(context).width >= kDesktopBreakpoint;
    final data = _data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: l.overviewTitle,
          actions: [
            MenuButton<String>(
              label: l.addNew,
              onSelected: (v) => context.go(v),
              itemBuilder: (_) => [
                PopupMenuItem(value: AppRoutes.invoiceNew, child: Text(l.newInvoice)),
                PopupMenuItem(value: AppRoutes.projects, child: Text(l.addNewProject)),
                PopupMenuItem(value: AppRoutes.bankConnect, child: Text(l.connectBank)),
              ],
            ),
          ],
        ),
        if (data?.hasExpiredConnections == true)
          AlertBanner(
            title: l.bankConnectionNeedsAttention,
            message: l.bankConnectionNeedsAttentionBody,
            actionLabel: l.manageBankConnections,
            onAction: () => context.go(AppRoutes.banking),
          ),
        _cashflowPanel(context, l, data, wide),
        _twoUp(wide, _invoicePanel(context, l, data), _bankingPanel(context, l, data)),
        _twoUp(wide, _recentPanel(context, l), _pnlPanel(context, l, data)),
      ],
    );
  }

  Widget _twoUp(bool wide, Widget a, Widget b) {
    if (!wide) return Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 20, children: [a, b]);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Expanded(child: a),
        Expanded(child: b),
      ],
    );
  }

  Widget _cashflowPanel(BuildContext context, AppLocalizations l, OverviewResponse? data, bool wide) {
    final cur = data?.currency ?? '';
    final chart = _loading || data == null
        ? const SkeletonLines(lines: 6)
        : BarChartPanel(
            currency: cur,
            series: [ChartSeries(l.incoming, AppColors.chartIn), ChartSeries(l.outgoing, AppColors.chartOut)],
            buckets: [
              for (final p in data.cashflow) ChartBucket(formatMonthKey(p.month), [p.inCents.toInt(), p.outCents.toInt()]),
            ],
          );
    final net = data == null ? Int64.ZERO : data.incomingCents - data.outgoingCents;
    final stats = StatColumn(
      tiles: [
        StatTile(
          label: l.incoming,
          value: formatMoney(data?.incomingCents ?? Int64.ZERO, currency: cur),
        ),
        StatTile(
          label: l.outgoing,
          value: formatMoney(data?.outgoingCents ?? Int64.ZERO, currency: cur),
        ),
        StatTile(
          label: l.balance,
          value: formatMoney(net, currency: cur),
          tone: net < Int64.ZERO ? StatTone.negative : StatTone.neutral,
        ),
      ],
    );
    return PanelCard(
      title: l.cashflow,
      padding: EdgeInsets.zero,
      trailing: HeaderDropdown<int>(
        value: _months,
        items: [
          for (final m in [3, 6, 12, 24]) DropdownMenuItem(value: m, child: Text(l.lastNMonths(m))),
        ],
        onChanged: (v) {
          if (v == null) return;
          setState(() => _months = v);
          _load();
        },
      ),
      child: wide
          ? IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(20), child: chart),
                  ),
                  Container(width: 1, color: Theme.of(context).dividerColor),
                  SizedBox(width: 260, child: stats),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(padding: const EdgeInsets.all(20), child: chart),
                const Divider(),
                stats,
              ],
            ),
    );
  }

  Widget _invoicePanel(BuildContext context, AppLocalizations l, OverviewResponse? data) {
    final theme = Theme.of(context);
    final cur = data?.currency ?? '';
    return PanelCard(
      tabs: [l.invoiceTimeline],
      tabIndex: _invoiceTab,
      onTab: (i) => setState(() => _invoiceTab = i),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(onPressed: () => context.go(AppRoutes.invoiceNew), child: Text(l.newInvoice)),
          TextButton(onPressed: () => context.go(AppRoutes.invoices), child: Text(l.viewAllInvoices)),
        ],
      ),
      child: _loading || data == null
          ? const SkeletonLines(lines: 5)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                BarChartPanel(
                  currency: cur,
                  stacked: true,
                  height: 200,
                  series: [ChartSeries(l.overdue, AppColors.chartOut), ChartSeries(l.due, AppColors.chartDue), ChartSeries(l.paid, AppColors.chartIn)],
                  buckets: [
                    for (final p in data.invoiceTimeline)
                      ChartBucket(formatMonthKey(p.month), [p.overdueCents.toInt(), p.dueCents.toInt(), p.paidCents.toInt()]),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        TextSpan(text: '${l.outstanding} '),
                        TextSpan(
                          text: formatMoney(data.outstandingCents, currency: cur),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _bankingPanel(BuildContext context, AppLocalizations l, OverviewResponse? data) {
    final theme = Theme.of(context);
    final cur = data?.currency ?? '';
    final history = _accountHistory?.points ?? data?.balanceHistory ?? [];
    final selected = _accounts.where((a) => a.id == _selectedAccount).firstOrNull;
    final balance = selected?.balanceCents ?? data?.totalBalanceCents ?? Int64.ZERO;
    return PanelCard(
      title: l.banking,
      trailing: _accounts.isEmpty
          ? null
          : HeaderDropdown<Int64>(
              value: _selectedAccount,
              items: [
                DropdownMenuItem(value: Int64.ZERO, child: Text(l.allAccounts)),
                for (final a in _accounts) DropdownMenuItem(value: a.id, child: Text(a.name)),
              ],
              onChanged: (v) => _loadAccountHistory(v ?? Int64.ZERO),
            ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(onPressed: () => context.go(AppRoutes.bankConnect), child: Text(l.connectBank)),
          TextButton(onPressed: () => context.go(AppRoutes.banking), child: Text(l.viewAllBankAccounts)),
        ],
      ),
      child: _loading || data == null
          ? const SkeletonLines(lines: 5)
          : !data.hasBankAccounts
          ? EmptyState(
              icon: Icons.account_balance_outlined,
              title: l.noBankAccountsYet,
              subtitle: l.noBankAccountsBody,
              buttonLabel: l.connectBank,
              onButtonPressed: () => context.go(AppRoutes.bankConnect),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.account_balance, color: theme.hintColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinkText(
                            selected?.name ?? l.allAccounts,
                            onTap: () => context.go(selected == null ? AppRoutes.banking : '${AppRoutes.bankAccount}/${selected.id}'),
                          ),
                          Text(formatDate(DateTime.now()), style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(formatMoney(balance, currency: selected?.currency ?? cur), style: theme.textTheme.titleLarge),
                        Text(l.balance, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                LineChartPanel(
                  currency: cur,
                  labels: [for (final p in history) formatMonthKey(p.month, withYear: true)],
                  values: [for (final p in history) p.balanceCents.toInt()],
                  height: 180,
                ),
              ],
            ),
    );
  }

  Widget _recentPanel(BuildContext context, AppLocalizations l) {
    final theme = Theme.of(context);
    return PanelCard(
      tabs: [l.expenses, l.forApproval],
      tabIndex: _bottomTab,
      onTab: (i) => setState(() => _bottomTab = i),
      padding: EdgeInsets.zero,
      child: Builder(
        builder: (context) {
          final rows = _bottomTab == 0
              ? _recent.where((t) => t.amountCents < Int64.ZERO).toList()
              : _recent.where((t) => t.status == TransactionStatus.TRANSACTION_STATUS_EXPLAINED).toList();
          if (_loading) return const SkeletonLines(lines: 4);
          if (rows.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(40),
              child: Center(child: Text(l.noRecentActivity, style: theme.textTheme.bodySmall)),
            );
          }
          return Column(
            children: [
              for (final t in rows.take(5))
                InkWell(
                  onTap: () => context.go('${AppRoutes.bankAccount}/${t.accountId}'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
                    ),
                    child: Row(
                      spacing: 12,
                      children: [
                        SizedBox(width: 72, child: Text(formatTimestamp(t.bookedAt), style: theme.textTheme.bodySmall)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.counterpartyName.isNotEmpty ? t.counterpartyName : t.description,
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(t.categoryName.isNotEmpty ? t.categoryName : l.unexplained, style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ),
                        MoneyText(t.amountCents, currency: t.currency),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _pnlPanel(BuildContext context, AppLocalizations l, OverviewResponse? data) {
    final theme = Theme.of(context);
    final cur = data?.currency ?? '';
    final income = data?.incomeCents ?? Int64.ZERO;
    final expenses = data?.expensesCents ?? Int64.ZERO;
    final profit = income - expenses;
    Widget cell(String label, Int64 value, {StatTone tone = StatTone.neutral}) => Expanded(
      child: StatTile(
        label: label,
        value: formatMoney(value, currency: cur),
        tone: tone,
      ),
    );
    Widget op(IconData icon) => Padding(
      padding: const EdgeInsets.only(right: 12, top: 22),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(shape: BoxShape.circle, color: theme.colorScheme.surfaceContainerHigh),
        child: Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
      ),
    );
    return PanelCard(
      tabs: [l.profitAndLoss],
      child: _loading || data == null
          ? const SkeletonLines(lines: 3)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                Row(
                  children: [
                    cell(l.income, income),
                    op(Icons.remove),
                    cell(l.expenses, expenses),
                    op(Icons.drag_handle),
                    cell(l.operatingProfit, profit, tone: profit < Int64.ZERO ? StatTone.negative : StatTone.positive),
                  ],
                ),
                const Divider(),
                Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  children: [
                    _countChip(context, l.forApproval, data.forApprovalCount, BadgeTone.warning),
                    _countChip(context, l.unexplained, data.unexplainedCount, BadgeTone.danger),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _countChip(BuildContext context, String label, int count, BadgeTone tone) {
    return InkWell(
      onTap: () => context.go(AppRoutes.banking),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          count == 0 ? Text('0', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)) : CountBadge(count: count, tone: tone),
        ],
      ),
    );
  }
}
