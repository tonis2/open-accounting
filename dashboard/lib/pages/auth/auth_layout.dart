import 'package:flutter/material.dart';

import '../../theme.dart';

/// Centered card on the blue-tinted background used by the sign-in pages.
class AuthLayout extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? footer;

  const AuthLayout({super.key, required this.title, this.subtitle, required this.child, this.footer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(height: 6, color: AppColors.nav),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    spacing: 20,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(color: AppColors.nav, borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.account_balance_outlined, color: Colors.white, size: 20),
                          ),
                          Text('Open Accounting', style: theme.textTheme.titleLarge),
                        ],
                      ),
                      Container(
                        decoration: panelDecoration(context),
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 20,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 6,
                              children: [
                                Text(title, style: theme.textTheme.headlineSmall),
                                if (subtitle != null) Text(subtitle!, style: theme.textTheme.bodySmall),
                              ],
                            ),
                            child,
                          ],
                        ),
                      ),
                      ?footer,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
