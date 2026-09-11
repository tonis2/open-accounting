import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/download.dart';
import '../../services/errors.dart';
import '../../services/format.dart';
import '../../state.dart';

/// Inline form under a transaction row: type, category, description, note, attachments,
/// invoice link, then "Approve & save" — mirrors the FreeAgent explain panel.
class ExplainForm extends StatefulWidget {
  final Transaction transaction;
  final List<Category> categories;
  final ValueChanged<Transaction> onSaved;
  final VoidCallback onCancel;

  const ExplainForm({super.key, required this.transaction, required this.categories, required this.onSaved, required this.onCancel});

  @override
  State<ExplainForm> createState() => _ExplainFormState();
}

class _ExplainFormState extends State<ExplainForm> {
  late Int64 _categoryId = widget.transaction.categoryId;
  late final _description = TextEditingController(text: widget.transaction.description);
  late final _note = TextEditingController(text: widget.transaction.note);
  List<Attachment> _attachments = [];
  List<Invoice> _openInvoices = [];
  bool _busy = false;
  bool _uploading = false;

  Transaction get tx => widget.transaction;
  bool get isIncome => tx.amountCents > Int64.ZERO;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadExtras());
  }

  @override
  void dispose() {
    _description.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _loadExtras() async {
    final state = Inherited.read(context);
    try {
      final atts = await state.server.listAttachments(ListAttachmentsRequest(companyId: tx.companyId, transactionId: tx.id));
      if (mounted) setState(() => _attachments = atts.items);
      if (isIncome) {
        final inv = await state.server.listInvoices(ListInvoicesRequest(companyId: tx.companyId, status: InvoiceStatus.INVOICE_STATUS_OPEN, pageSize: 100));
        if (mounted) setState(() => _openInvoices = inv.items);
      }
    } catch (e) {
      AppLogger.debug('explain extras failed', error: e);
    }
  }

  Future<void> _save({required bool approve}) async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    setState(() => _busy = true);
    try {
      final updated = await state.server.explainTransaction(
        ExplainTransactionRequest(
          companyId: tx.companyId,
          id: tx.id,
          categoryId: _categoryId,
          note: _note.text.trim(),
          description: _description.text.trim(),
          approve: approve,
        ),
      );
      AppLogger.info(l.transactionExplained);
      widget.onSaved(updated);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _upload() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    final result = await FilePicker.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'webp'],
    );
    if (result == null) return;
    setState(() => _uploading = true);
    for (final f in result.files) {
      final data = f.bytes;
      if (data == null) continue;
      if (data.length > 10 * 1024 * 1024) {
        AppLogger.warning(l.attachmentTooLarge);
        continue;
      }
      try {
        final att = await state.server.uploadAttachment(UploadAttachmentRequest(companyId: tx.companyId, transactionId: tx.id, filename: f.name, data: data));
        setState(() => _attachments.add(att));
        AppLogger.info(l.attachmentUploaded);
      } catch (e) {
        AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
      }
    }
    if (mounted) setState(() => _uploading = false);
  }

  Future<void> _openAttachment(Attachment a) async {
    final state = Inherited.read(context);
    try {
      final file = await state.server.getAttachment(CompanyIdRequest(companyId: tx.companyId, id: a.id));
      downloadBytes(file.filename, Uint8List.fromList(file.data), file.mime);
    } catch (e) {
      AppLogger.error(errorMessage(e), error: e);
    }
  }

  Future<void> _deleteAttachment(Attachment a) async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      await state.server.deleteAttachment(CompanyIdRequest(companyId: tx.companyId, id: a.id));
      setState(() => _attachments.removeWhere((x) => x.id == a.id));
      AppLogger.info(l.attachmentDeleted);
    } catch (e) {
      AppLogger.error(errorMessage(e), error: e);
    }
  }

  Future<void> _link(Int64 invoiceId) async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      final updated = await state.server.linkTransactionToInvoice(LinkTransactionRequest(companyId: tx.companyId, transactionId: tx.id, invoiceId: invoiceId));
      AppLogger.info(invoiceId == Int64.ZERO ? l.transactionUnlinked : l.transactionLinked);
      widget.onSaved(updated);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final kind = isIncome ? CategoryKind.CATEGORY_KIND_INCOME : CategoryKind.CATEGORY_KIND_EXPENSE;
    final cats = widget.categories.where((c) => c.kind == kind).toList();

    Widget labelled(String label, Widget child) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Align(alignment: Alignment.centerLeft, child: child),
          ),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(56, 4, 24, 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          labelled(
            l.transactionType,
            SizedBox(
              width: 260,
              child: InputDecorator(
                decoration: const InputDecoration(),
                child: Text(isIncome ? l.transactionTypeIn : l.transactionTypeOut, style: theme.textTheme.bodyMedium),
              ),
            ),
          ),
          labelled(
            l.transactionCategory,
            SizedBox(
              width: 340,
              child: AppDropdown<Int64>(
                value: _categoryId == Int64.ZERO ? null : _categoryId,
                hint: l.transactionCategoryHint,
                items: [for (final c in cats) DropdownMenuItem(value: c.id, child: Text(c.name))],
                onChanged: (v) => setState(() => _categoryId = v ?? Int64.ZERO),
              ),
            ),
          ),
          labelled(l.transactionDescription, TextField(controller: _description)),
          labelled(
            l.transactionNote,
            TextField(
              controller: _note,
              maxLines: 2,
              decoration: InputDecoration(hintText: l.transactionNoteHint),
            ),
          ),
          if (tx.reference.isNotEmpty || tx.counterpartyIban.isNotEmpty)
            labelled(
              l.transactionReference,
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text([tx.reference, tx.counterpartyIban].where((s) => s.isNotEmpty).join(' · '), style: theme.textTheme.bodySmall),
              ),
            ),
          labelled(
            l.transactionAttachments,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final a in _attachments)
                      InputChip(
                        avatar: Icon(a.mime == 'application/pdf' ? Icons.picture_as_pdf_outlined : Icons.image_outlined, size: 16),
                        label: Text(a.filename, overflow: TextOverflow.ellipsis),
                        onPressed: () => _openAttachment(a),
                        onDeleted: () => _deleteAttachment(a),
                      ),
                    BusyButton(
                      busy: _uploading,
                      outlined: true,
                      onPressed: _upload,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6,
                        children: [const Icon(Icons.upload_file, size: 18), Text(l.transactionUploadFiles)],
                      ),
                    ),
                  ],
                ),
                Text(l.transactionUploadHint, style: theme.textTheme.labelSmall),
              ],
            ),
          ),
          if (isIncome)
            labelled(
              l.transactionLinkInvoice,
              tx.invoiceId != Int64.ZERO
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12,
                      children: [
                        StatusBadge(label: l.transactionLinkedInvoice(tx.invoiceNumber), tone: BadgeTone.success),
                        TextButton(onPressed: () => _link(Int64.ZERO), child: Text(l.transactionUnlinkInvoice)),
                      ],
                    )
                  : _openInvoices.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(l.transactionNoOpenInvoices, style: theme.textTheme.bodySmall),
                    )
                  : SizedBox(
                      width: 420,
                      child: AppDropdown<Int64>(
                        value: null,
                        hint: l.transactionChooseInvoice,
                        items: [
                          for (final inv in _openInvoices)
                            DropdownMenuItem(
                              value: inv.id,
                              child: Text(
                                '${inv.number} · ${inv.projectName} · ${formatMoney(inv.totalCents, currency: inv.currency)}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: (v) => v == null ? null : _link(v),
                      ),
                    ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 146),
            child: Row(
              spacing: 12,
              children: [
                BusyButton(busy: _busy, onPressed: _categoryId == Int64.ZERO ? null : () => _save(approve: true), child: Text(l.transactionApproveAndSave)),
                BusyButton(busy: _busy, outlined: true, onPressed: () => _save(approve: false), child: Text(l.transactionSaveExplanation)),
                TextButton(onPressed: widget.onCancel, child: Text(l.cancel)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
