import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../state.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> _categories = [];
  bool _loading = true;
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
      final res = await state.server.listCategories(CompanyRequest(companyId: _companyId));
      if (mounted) setState(() => _categories = res.items);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _edit([Category? existing]) async {
    final l = AppLocalizations.of(context)!;
    final state = Inherited.read(context);
    final name = TextEditingController(text: existing?.name ?? '');
    var kind = existing?.kind ?? CategoryKind.CATEGORY_KIND_EXPENSE;
    final formKey = GlobalKey<FormState>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => DialogShell(
          title: existing == null ? l.addCategory : l.editCategory,
          width: 440,
          body: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                AppTextField(
                  label: l.categoryName,
                  controller: name,
                  required: true,
                  autofocus: true,
                  validator: (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null,
                ),
                AppDropdown<CategoryKind>(
                  label: l.categoryKind,
                  value: kind,
                  items: [
                    DropdownMenuItem(value: CategoryKind.CATEGORY_KIND_INCOME, child: Text(l.categoryKindIncome)),
                    DropdownMenuItem(value: CategoryKind.CATEGORY_KIND_EXPENSE, child: Text(l.categoryKindExpense)),
                  ],
                  onChanged: (v) => setState(() => kind = v ?? kind),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
            ElevatedButton(onPressed: () => formKey.currentState!.validate() ? Navigator.pop(ctx, true) : null, child: Text(l.save)),
          ],
        ),
      ),
    );
    if (ok != true) return;
    try {
      final c = Category(id: existing?.id, companyId: _companyId, name: name.text.trim(), kind: kind, sortOrder: existing?.sortOrder);
      existing == null ? await state.server.createCategory(c) : await state.server.updateCategory(c);
      AppLogger.info(l.categorySaved);
      _load();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  Future<void> _delete(Category c) async {
    final l = AppLocalizations.of(context)!;
    if (!await confirmDialog(
      context,
      title: l.delete,
      message: l.deleteCategoryConfirm(c.name),
      confirmLabel: l.delete,
      cancelLabel: l.cancel,
      destructive: true,
    )) {
      return;
    }
    if (!mounted) return;
    final state = Inherited.read(context);
    try {
      await state.server.deleteCategory(CompanyIdRequest(companyId: _companyId, id: c.id));
      AppLogger.info(l.categoryDeleted);
      _load();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    Widget table(CategoryKind kind, String title) {
      final rows = _categories.where((c) => c.kind == kind).toList();
      return PanelCard(
        title: title,
        padding: EdgeInsets.zero,
        child: CustomTable(
          bordered: false,
          columns: [
            TableColumn(header: l.categoryName, size: const FlexColumn(4)),
            const TableColumn(header: '', size: FixedColumn(96), align: TextAlign.right),
          ],
          itemCount: rows.length,
          emptyState: Text(l.noResults),
          rowBuilder: (i) => [
            Text(rows[i].name),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(icon: const Icon(Icons.edit_outlined, size: 18), onPressed: () => _edit(rows[i])),
                IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () => _delete(rows[i])),
              ],
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: l.categoriesTitle,
          subtitle: l.categoriesSubtitle,
          actions: [ElevatedButton(onPressed: () => _edit(), child: Text(l.addCategory))],
        ),
        if (_loading)
          const PanelCard(child: SkeletonLines())
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final a = table(CategoryKind.CATEGORY_KIND_INCOME, l.categoryKindIncome);
              final b = table(CategoryKind.CATEGORY_KIND_EXPENSE, l.categoryKindExpense);
              if (constraints.maxWidth < 800) return Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 20, children: [a, b]);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Expanded(child: a),
                  Expanded(child: b),
                ],
              );
            },
          ),
      ],
    );
  }
}
