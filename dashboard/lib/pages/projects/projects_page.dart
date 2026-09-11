import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../responsive.dart';
import '../../services/errors.dart';
import '../../state.dart';
import 'project_form_dialog.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Project> _projects = [];
  bool _loading = true;
  bool _includeInactive = false;
  SortState _sort = const SortState('name');
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
    setState(() => _loading = true);
    try {
      final res = await state.server.listProjects(ListProjectsRequest(companyId: _companyId, includeInactive: _includeInactive));
      if (mounted) setState(() => _projects = res.items);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<Project> get _sorted {
    final list = [..._projects];
    int cmp(Project a, Project b) => switch (_sort.key) {
      'contact' => a.contactName.toLowerCase().compareTo(b.contactName.toLowerCase()),
      'invoiced' => a.invoicedCents.compareTo(b.invoicedCents),
      'outstanding' => a.outstandingCents.compareTo(b.outstandingCents),
      _ => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    };
    list.sort((a, b) => _sort.ascending ? cmp(a, b) : cmp(b, a));
    return list;
  }

  Future<void> _create() async {
    final saved = await ProjectFormDialog.show(context);
    if (saved != null) _load();
  }

  Future<void> _edit(Project p) async {
    final saved = await ProjectFormDialog.show(context, project: p);
    if (saved != null) _load();
  }

  Future<void> _delete(Project p) async {
    final l = AppLocalizations.of(context)!;
    final ok = await confirmDialog(
      context,
      title: l.remove,
      message: l.deleteProjectConfirm(p.name),
      confirmLabel: l.remove,
      cancelLabel: l.cancel,
      destructive: true,
    );
    if (!ok || !mounted) return;
    final state = Inherited.read(context);
    try {
      await state.server.deleteProject(CompanyIdRequest(companyId: _companyId, id: p.id));
      AppLogger.info(l.projectDeleted);
      _load();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final cur = Inherited.of(context).activeCompany?.currency ?? '';
    final wide = isDesktop(context);
    final rows = _sorted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: l.projectsTitle,
          actions: [ElevatedButton(onPressed: _create, child: Text(l.addNewProject))],
        ),
        PanelCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HeaderDropdown<bool>(
                    value: _includeInactive,
                    items: [
                      DropdownMenuItem(value: false, child: Text(l.activeProjects)),
                      DropdownMenuItem(value: true, child: Text(l.allProjects)),
                    ],
                    onChanged: (v) {
                      setState(() => _includeInactive = v ?? false);
                      _load();
                    },
                  ),
                ),
              ),
              if (_loading)
                const SkeletonLines()
              else
                CustomTable(
                  bordered: false,
                  sort: _sort,
                  onSort: (s) => setState(() => _sort = s),
                  columns: [
                    TableColumn(header: l.name, size: const FlexColumn(3), sortKey: 'name'),
                    if (wide) TableColumn(header: l.projectContact, size: const FlexColumn(3), sortKey: 'contact'),
                    if (wide) TableColumn(header: l.projectInvoiceCount, size: const FlexColumn(1), align: TextAlign.right),
                    TableColumn(header: l.projectInvoiced, size: const FlexColumn(2), align: TextAlign.right, sortKey: 'invoiced'),
                    TableColumn(header: l.projectOutstanding, size: const FlexColumn(2), align: TextAlign.right, sortKey: 'outstanding'),
                    const TableColumn(header: '', size: FixedColumn(124), align: TextAlign.right),
                  ],
                  itemCount: rows.length,
                  emptyState: EmptyState(
                    icon: Icons.folder_outlined,
                    title: l.noProjectsTitle,
                    subtitle: l.noProjectsBody,
                    buttonLabel: l.addNewProject,
                    onButtonPressed: _create,
                  ),
                  rowBuilder: (i) {
                    final p = rows[i];
                    return [
                      Row(
                        spacing: 8,
                        children: [
                          Flexible(child: LinkText(p.name, onTap: () => context.go('${AppRoutes.project}/${p.id}'))),
                          if (!p.isActive) StatusBadge(label: l.projectArchived),
                        ],
                      ),
                      if (wide)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (p.contactName.isNotEmpty) Text(p.contactName, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                            if (p.email.isNotEmpty) Text(p.email, style: theme.textTheme.bodySmall),
                          ],
                        ),
                      if (wide) Text('${p.invoiceCount}', style: theme.textTheme.bodyMedium),
                      MoneyText(p.invoicedCents, currency: cur),
                      MoneyText(p.outstandingCents, currency: cur),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => _edit(p),
                            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
                            child: Text(l.edit),
                          ),
                          PopupMenuButton<String>(
                            tooltip: '',
                            onSelected: (v) => v == 'delete' ? _delete(p) : context.go('${AppRoutes.invoiceNew}?project=${p.id}'),
                            itemBuilder: (_) => [
                              PopupMenuItem(value: 'invoice', child: Text(l.newInvoice)),
                              PopupMenuItem(value: 'delete', child: Text(l.remove)),
                            ],
                            icon: const Icon(Icons.more_vert, size: 18),
                          ),
                        ],
                      ),
                    ];
                  },
                ),
              if (!_loading && rows.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('${rows.length} ${l.projectsTitle.toLowerCase()}', style: theme.textTheme.bodySmall),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
