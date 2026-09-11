import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';

/// Multiline provider field (PEM keys) filled from a file, with paste as a fallback.
class KeyFileField extends StatefulWidget {
  const KeyFileField({super.key, required this.label, required this.controller, this.helper, this.hint, this.validator});

  final String label;
  final TextEditingController controller;
  final String? helper;
  final String? hint;
  final FormFieldValidator<String>? validator;

  @override
  State<KeyFileField> createState() => _KeyFileFieldState();
}

class _KeyFileFieldState extends State<KeyFileField> {
  String? _fileName;
  bool _paste = false;

  Future<void> _pick() async {
    final result = await FilePicker.pickFiles(withData: true, type: FileType.custom, allowedExtensions: ['pem', 'key', 'txt']);
    final file = result?.files.firstOrNull;
    if (file?.bytes == null) return;
    setState(() {
      widget.controller.text = utf8.decode(file!.bytes!, allowMalformed: true).trim();
      _fileName = file.name;
      _paste = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final status = _fileName ?? widget.hint ?? l.noFileChosen;
    return FormField<String>(
      validator: (_) => widget.validator?.call(widget.controller.text),
      builder: (field) => Labeled(
        label: widget.label,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Row(
              spacing: 12,
              children: [
                OutlinedButton.icon(onPressed: _pick, icon: const Icon(Icons.upload_file_outlined, size: 18), label: Text(l.chooseFile)),
                Expanded(
                  child: Text(status, style: theme.textTheme.bodySmall, overflow: TextOverflow.ellipsis),
                ),
                TextButton(onPressed: () => setState(() => _paste = !_paste), child: Text(l.pasteInstead)),
              ],
            ),
            if (_paste)
              TextField(controller: widget.controller, maxLines: 6, style: theme.textTheme.bodySmall, onChanged: (_) => setState(() => _fileName = null)),
            if (widget.helper != null) Text(widget.helper!, style: theme.textTheme.bodySmall),
            if (field.hasError) Text(field.errorText!, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error)),
          ],
        ),
      ),
    );
  }
}
