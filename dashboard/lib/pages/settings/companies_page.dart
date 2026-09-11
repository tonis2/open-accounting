import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../state.dart';
import 'company_form.dart';

/// Lists the user's companies; also hosts the first-company wizard (?new=1).
class CompaniesPage extends StatefulWidget {
  final bool startNew;
  const CompaniesPage({super.key, this.startNew = false});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  late bool _creating = widget.startNew;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final state = Inherited.of(context);
    final firstCompany = state.companies.isEmpty;

    if (_creating || firstCompany) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          PageHeader(
            title: firstCompany ? l.companyWizardTitle : l.createCompany,
            subtitle: firstCompany ? l.companyWizardSubtitle : null,
            leading: firstCompany ? null : IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => setState(() => _creating = false)),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: PanelCard(
              child: CompanyForm(
                submitLabel: l.createCompany,
                onSaved: (saved) async {
                  await state.loadCompanies();
                  state.switchCompany(saved);
                  AppLogger.info(l.companyCreated);
                  if (context.mounted) context.go(AppRoutes.overview);
                },
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: l.companiesTitle,
          subtitle: l.companiesSubtitle,
          actions: [ElevatedButton(onPressed: () => setState(() => _creating = true), child: Text(l.createCompany))],
        ),
        PanelCard(
          padding: EdgeInsets.zero,
          child: CustomTable(
            bordered: false,
            columns: [
              TableColumn(header: l.companyName, size: const FlexColumn(4)),
              TableColumn(header: l.companyCurrency, size: const FlexColumn(1)),
              TableColumn(header: l.companyRoleOwner, size: const FlexColumn(2)),
              const TableColumn(header: '', size: FixedColumn(140), align: TextAlign.right),
            ],
            itemCount: state.companies.length,
            rowBuilder: (i) {
              final c = state.companies[i];
              final active = c.id == state.activeCompany?.id;
              return [
                Row(
                  spacing: 8,
                  children: [
                    Text(c.name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                    if (active) StatusBadge(label: l.companyActive, tone: BadgeTone.success),
                  ],
                ),
                Text(c.currency),
                Text(c.role == 'owner' ? l.companyRoleOwner : l.companyRoleMember),
                active
                    ? OutlinedButton(onPressed: () => context.go(AppRoutes.settingsCompany), child: Text(l.edit))
                    : OutlinedButton(
                        onPressed: () {
                          state.switchCompany(c);
                          context.go(AppRoutes.overview);
                        },
                        child: Text(l.switchCompany),
                      ),
              ];
            },
          ),
        ),
      ],
    );
  }
}
