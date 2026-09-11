import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../state.dart';

/// Create or edit a project (client). Returns the saved project.
class ProjectFormDialog extends StatefulWidget {
  final Project? project;
  const ProjectFormDialog({super.key, this.project});

  static Future<Project?> show(BuildContext context, {Project? project}) {
    return showDialog<Project>(
      context: context,
      builder: (_) => ProjectFormDialog(project: project),
    );
  }

  @override
  State<ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<ProjectFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.project?.name ?? '');
  late final _email = TextEditingController(text: widget.project?.email ?? '');
  late final _contact = TextEditingController(text: widget.project?.contactName ?? '');
  late final _address = TextEditingController(text: widget.project?.address ?? '');
  late final _reg = TextEditingController(text: widget.project?.regNumber ?? '');
  late final _vat = TextEditingController(text: widget.project?.vatNumber ?? '');
  late final _description = TextEditingController(text: widget.project?.description ?? '');
  late bool _active = widget.project?.isActive ?? true;
  bool _busy = false;

  @override
  void dispose() {
    for (final c in [_name, _email, _contact, _address, _reg, _vat, _description]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    final state = Inherited.read(context);
    setState(() => _busy = true);
    final p = Project(
      id: widget.project?.id,
      companyId: state.companyId,
      name: _name.text.trim(),
      email: _email.text.trim(),
      contactName: _contact.text.trim(),
      address: _address.text.trim(),
      regNumber: _reg.text.trim(),
      vatNumber: _vat.text.trim(),
      description: _description.text.trim(),
      isActive: _active,
    );
    try {
      final saved = widget.project == null ? await state.server.createProject(p) : await state.server.updateProject(p);
      AppLogger.info(l.projectSaved);
      if (mounted) Navigator.pop(context, saved);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DialogShell(
      title: widget.project == null ? l.addNewProject : l.editProject,
      width: 560,
      actions: [
        OutlinedButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel)),
        BusyButton(busy: _busy, onPressed: _save, child: Text(l.save)),
      ],
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            AppTextField(
              label: l.projectName,
              controller: _name,
              required: true,
              autofocus: true,
              validator: (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null,
            ),
            FormRow(
              children: [
                AppTextField(
                  label: l.projectEmail,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v != null && v.isNotEmpty && !v.contains('@')) ? l.invalidEmail : null,
                ),
                AppTextField(label: l.projectContactName, controller: _contact),
              ],
            ),
            AppTextField(label: l.projectAddress, controller: _address, maxLines: 2),
            FormRow(
              children: [
                AppTextField(label: l.projectRegNumber, controller: _reg),
                AppTextField(label: l.projectVatNumber, controller: _vat),
              ],
            ),
            AppTextField(label: l.projectDescription, controller: _description, maxLines: 3),
            if (widget.project != null)
              Row(
                spacing: 8,
                children: [
                  Switch(value: _active, onChanged: (v) => setState(() => _active = v)),
                  Text(l.projectIsActive),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
