import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/format.dart';

/// Label above a field — FreeAgent forms use plain labels rather than floating ones.
class Labeled extends StatelessWidget {
  final String label;
  final Widget child;
  final bool required;
  final String? hint;

  const Labeled({super.key, required this.label, required this.child, this.required = false, this.hint});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style: theme.textTheme.labelLarge,
            children: [
              if (required)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
            ],
          ),
        ),
        child,
        if (hint != null) Text(hint!, style: theme.textTheme.labelSmall),
      ],
    );
  }
}

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? helper;
  final bool required;
  final bool obscure;
  final int maxLines;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextAlign textAlign;
  final Widget? suffix;

  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.helper,
    this.required = false,
    this.obscure = false,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.enabled = true,
    this.inputFormatters,
    this.autofillHints,
    this.textAlign = TextAlign.start,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Labeled(
      label: label,
      required: required,
      hint: helper,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        autofocus: autofocus,
        enabled: enabled,
        inputFormatters: inputFormatters,
        autofillHints: autofillHints,
        textAlign: textAlign,
        decoration: InputDecoration(hintText: hint, suffixIcon: suffix),
      ),
    );
  }
}

class AppDropdown<T> extends StatelessWidget {
  final String? label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final bool required;
  final bool dense;

  const AppDropdown({super.key, this.label, required this.value, required this.items, this.onChanged, this.hint, this.required = false, this.dense = false});

  @override
  Widget build(BuildContext context) {
    final field = DropdownButtonFormField<T>(
      initialValue: items.any((i) => i.value == value) ? value : null,
      items: items,
      onChanged: onChanged,
      isDense: true,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, size: 20),
      decoration: InputDecoration(hintText: hint, contentPadding: dense ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : null),
      style: Theme.of(context).textTheme.bodyMedium,
    );
    if (label == null) return field;
    return Labeled(label: label!, required: required, child: field);
  }
}

/// Compact dropdown used in panel headers ("Last 12 months", "All accounts").
class HeaderDropdown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const HeaderDropdown({super.key, required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(6),
        color: theme.colorScheme.surface,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: theme.textTheme.bodyMedium,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

/// Date field that opens the material date picker; value is stored as ISO "YYYY-MM-DD".
class AppDateField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool required;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const AppDateField({super.key, required this.label, required this.value, required this.onChanged, this.required = false, this.firstDate, this.lastDate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = parseIsoDate(value);
    return Labeled(
      label: label,
      required: required,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: date ?? DateTime.now(),
            firstDate: firstDate ?? DateTime(2000),
            lastDate: lastDate ?? DateTime(2100),
          );
          if (picked != null) onChanged(isoDate(picked));
        },
        child: InputDecorator(
          decoration: const InputDecoration(suffixIcon: Icon(Icons.calendar_today_outlined, size: 18)),
          child: Text(date == null ? '' : formatDateLong(date), style: theme.textTheme.bodyMedium),
        ),
      ),
    );
  }
}

/// Two-column form row that stacks on narrow screens.
class FormRow extends StatelessWidget {
  final List<Widget> children;
  const FormRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 520) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 16, children: children);
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [for (final c in children) Expanded(child: c)],
        );
      },
    );
  }
}

/// Section heading inside forms/pages.
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const SectionTitle(this.title, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        if (subtitle != null) Text(subtitle!, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

/// Button that shows a spinner while [busy].
class BusyButton extends StatelessWidget {
  final bool busy;
  final VoidCallback? onPressed;
  final Widget child;
  final bool outlined;
  final bool filled;

  const BusyButton({super.key, required this.busy, required this.onPressed, required this.child, this.outlined = false, this.filled = false});

  @override
  Widget build(BuildContext context) {
    final content = busy ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : child;
    final cb = busy ? null : onPressed;
    if (outlined) return OutlinedButton(onPressed: cb, child: content);
    if (filled) return FilledButton(onPressed: cb, child: content);
    return ElevatedButton(onPressed: cb, child: content);
  }
}

/// Text that looks like a FreeAgent link (blue, bold), used inside tables.
class LinkText extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool bold;
  const LinkText(this.text, {super.key, this.onTap, this.bold = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: bold ? FontWeight.w700 : FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
