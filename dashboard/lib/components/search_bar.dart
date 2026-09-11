import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final double? width;

  const AppSearchBar({super.key, required this.hintText, this.controller, this.onChanged, this.onSubmitted, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(hintText: hintText, prefixIcon: const Icon(Icons.search, size: 20)),
      ),
    );
  }
}
