import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/download.dart';
import '../../services/errors.dart';
import '../../services/format.dart';
import '../../state.dart';

/// "Actions ▾" menu shared by the invoice list and detail page. Calls [onChanged] after mutations.
class InvoiceActionsButton extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback onChanged;
  final bool primary;

  const InvoiceActionsButton({super.key, required this.invoice, required this.onChanged, this.primary = false});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final inv = invoice;
    final isDraft = inv.status == InvoiceStatus.INVOICE_STATUS_DRAFT;
    final isOpen = inv.status == InvoiceStatus.INVOICE_STATUS_OPEN;
    final isPaid = inv.status == InvoiceStatus.INVOICE_STATUS_PAID;

    return MenuButton<String>(
      label: l.actions,
      style: primary ? MenuButtonStyle.primary : MenuButtonStyle.outlined,
      compact: !primary,
      onSelected: (action) => InvoiceActions(context, inv, onChanged).run(action),
      itemBuilder: (_) => [
        PopupMenuItem(value: 'view', child: Text(l.view)),
        if (isDraft) PopupMenuItem(value: 'edit', child: Text(l.edit)),
        if (isDraft) PopupMenuItem(value: 'issue', child: Text(l.invoiceIssue)),
        if (!isDraft) PopupMenuItem(value: 'pdf', child: Text(l.invoiceDownloadPdf)),
        if (isOpen) PopupMenuItem(value: 'send', child: Text(l.invoiceSend)),
        if (isOpen) PopupMenuItem(value: 'paid', child: Text(l.invoiceMarkPaid)),
        if (isPaid) PopupMenuItem(value: 'unpaid', child: Text(l.invoiceUnlinkPayment)),
        if (isDraft || isOpen) const PopupMenuDivider(),
        if (isOpen) PopupMenuItem(value: 'cancel', child: Text(l.invoiceCancel)),
        if (isDraft) PopupMenuItem(value: 'delete', child: Text(l.invoiceDelete)),
      ],
    );
  }
}

/// Invoice mutations with confirmation dialogs and toasts.
class InvoiceActions {
  final BuildContext context;
  final Invoice inv;
  final VoidCallback onChanged;

  InvoiceActions(this.context, this.inv, this.onChanged);

  AppLocalizations get l => AppLocalizations.of(context)!;
  AppState get state => Inherited.read(context);
  CompanyIdRequest get ref => CompanyIdRequest(companyId: inv.companyId, id: inv.id);

  Future<void> run(String action) async {
    switch (action) {
      case 'view':
        context.go('${AppRoutes.invoice}/${inv.id}');
      case 'edit':
        context.go('${AppRoutes.invoice}/${inv.id}/edit');
      case 'issue':
        await issue();
      case 'pdf':
        await downloadPdf();
      case 'send':
        await send();
      case 'paid':
        await markPaid();
      case 'unpaid':
        await _guard(() async {
          await state.server.unlinkInvoicePayment(ref);
          AppLogger.info(l.invoiceReopened);
        });
      case 'cancel':
        if (await confirmDialog(
          context,
          title: l.invoiceCancel,
          message: l.invoiceCancelConfirm(inv.number),
          confirmLabel: l.invoiceCancel,
          cancelLabel: l.back,
          destructive: true,
        )) {
          await _guard(() async {
            await state.server.cancelInvoice(ref);
            AppLogger.info(l.invoiceCancelled);
          });
        }
      case 'delete':
        if (await confirmDialog(
          context,
          title: l.invoiceDelete,
          message: l.invoiceDeleteConfirm,
          confirmLabel: l.delete,
          cancelLabel: l.cancel,
          destructive: true,
        )) {
          await _guard(() async {
            await state.server.deleteInvoice(ref);
            AppLogger.info(l.invoiceDeleted);
            if (context.mounted) context.go(AppRoutes.invoices);
          });
        }
    }
  }

  Future<void> issue() async {
    if (!await confirmDialog(context, title: l.invoiceIssue, message: l.invoiceIssueConfirm, confirmLabel: l.invoiceIssue, cancelLabel: l.cancel)) return;
    await _guard(() async {
      final issued = await state.server.issueInvoice(ref);
      AppLogger.info(l.invoiceIssued(issued.number));
    });
  }

  Future<void> downloadPdf() async {
    await _guard(() async {
      final file = await state.server.getInvoicePdf(ref);
      downloadBytes(file.filename, Uint8List.fromList(file.data), file.mime);
    }, notify: false);
  }

  Future<void> send() async {
    Project? project;
    try {
      project = await state.server.getProject(CompanyIdRequest(companyId: inv.companyId, id: inv.projectId));
    } catch (_) {}
    if (!context.mounted) return;
    final email = project?.email ?? '';
    if (!await confirmDialog(context, title: l.invoiceSend, message: l.invoiceSendConfirm(email), confirmLabel: l.invoiceSend, cancelLabel: l.cancel)) return;
    await _guard(() async {
      await state.server.sendInvoice(ref);
      AppLogger.info(l.invoiceSent);
    });
  }

  Future<void> markPaid() async {
    var date = isoDate(DateTime.now());
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => DialogShell(
          title: l.invoiceMarkPaidTitle,
          width: 420,
          body: AppDateField(label: l.invoicePaidDate, value: date, onChanged: (v) => setState(() => date = v), lastDate: DateTime.now()),
          actions: [
            OutlinedButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.invoiceMarkPaid)),
          ],
        ),
      ),
    );
    if (ok != true) return;
    await _guard(() async {
      await state.server.markInvoicePaid(MarkInvoicePaidRequest(companyId: inv.companyId, id: inv.id, paidDate: date));
      AppLogger.info(l.invoiceMarkedPaid);
    });
  }

  Future<void> _guard(Future<void> Function() fn, {bool notify = true}) async {
    try {
      await fn();
      if (notify) onChanged();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }
}
