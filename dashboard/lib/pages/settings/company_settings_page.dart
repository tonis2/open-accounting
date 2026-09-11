import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../state.dart';
import 'company_form.dart';

class CompanySettingsPage extends StatelessWidget {
  const CompanySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final state = Inherited.of(context);
    final company = state.activeCompany;
    if (company == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(title: l.navCompanySettings, subtitle: company.name),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: PanelCard(
            child: CompanyForm(
              key: ValueKey(company.id),
              company: company,
              submitLabel: l.saveChanges,
              onSaved: (saved) {
                state.updateCompany(saved);
                AppLogger.info(l.companySaved);
              },
            ),
          ),
        ),
      ],
    );
  }
}
