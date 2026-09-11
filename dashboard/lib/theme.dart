import 'package:flutter/material.dart';

/// Design tokens derived from the reference screenshots.
class AppColors {
  static const nav = Color(0xFF1F6FB5);
  static const navActive = Color(0xFF17588F);
  static const background = Color(0xFFF2F6FA);
  static const surface = Colors.white;
  static const surfaceMuted = Color(0xFFF7F9FC);
  static const border = Color(0xFFDDE3EA);
  static const borderLight = Color(0xFFEEF2F6);
  static const textPrimary = Color(0xFF1E2A36);
  static const textSecondary = Color(0xFF5B6B7B);
  static const textHint = Color(0xFF8A98A6);
  static const link = Color(0xFF1A73C9);
  static const action = Color(0xFF6DBE45);
  static const actionText = Color(0xFF10301A);
  static const success = Color(0xFF3A8F3A);
  static const successBg = Color(0xFFE6F4E6);
  static const warning = Color(0xFFE0851A);
  static const warningBg = Color(0xFFFFF3E0);
  static const danger = Color(0xFFD93025);
  static const dangerBg = Color(0xFFFCE8E6);
  static const info = Color(0xFF2F8FE5);
  static const infoBg = Color(0xFFE3F0FB);
  static const chartIn = Color(0xFF5CB85C);
  static const chartOut = Color(0xFFE5484D);
  static const chartLine = Color(0xFF2F8FE5);
  static const chartLineFill = Color(0xFFCCE4F7);
  static const chartDue = Color(0xFFF5A623);
}

const _radius = 6.0;
const _radiusLg = 10.0;

/// Card decoration shared by panels and tables so every surface looks the same.
BoxDecoration panelDecoration(BuildContext context) {
  final theme = Theme.of(context);
  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(_radiusLg),
    border: Border.all(color: theme.dividerColor),
  );
}

final ThemeData appThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: AppColors.link,
    onPrimary: Colors.white,
    secondary: AppColors.action,
    onSecondary: AppColors.actionText,
    tertiary: AppColors.nav,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    surfaceContainerLowest: AppColors.surface,
    surfaceContainerLow: AppColors.surfaceMuted,
    surfaceContainer: AppColors.surfaceMuted,
    surfaceContainerHigh: AppColors.background,
    surfaceContainerHighest: AppColors.background,
    outline: AppColors.border,
    outlineVariant: AppColors.borderLight,
    error: AppColors.danger,
    onError: Colors.white,
    surfaceTint: Colors.transparent,
  ),
  scaffoldBackgroundColor: AppColors.background,
  canvasColor: AppColors.surface,
  dividerColor: AppColors.border,
  hintColor: AppColors.textHint,
  splashFactory: NoSplash.splashFactory,

  textTheme: const TextTheme(
    headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: -0.5),
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: -0.3),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
    titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    bodyLarge: TextStyle(fontSize: 15, color: AppColors.textPrimary),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.textPrimary),
    bodySmall: TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    labelMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
    labelSmall: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500, color: AppColors.textHint, letterSpacing: 0.2),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.nav,
    foregroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    toolbarHeight: 56,
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
  ),

  cardTheme: CardThemeData(
    color: AppColors.surface,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_radiusLg),
      side: const BorderSide(color: AppColors.border),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    hintStyle: const TextStyle(fontSize: 14, color: AppColors.textHint),
    labelStyle: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
    floatingLabelStyle: const TextStyle(fontSize: 14, color: AppColors.link),
    prefixIconColor: AppColors.textHint,
    suffixIconColor: AppColors.textHint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: const BorderSide(color: AppColors.link, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: const BorderSide(color: AppColors.danger),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
    ),
  ),

  // Primary action: FreeAgent green with dark text.
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.action,
      foregroundColor: AppColors.actionText,
      disabledBackgroundColor: AppColors.border,
      elevation: 0,
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.link,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
    ),
  ),
  // Secondary action: white with blue text and grey border.
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.link,
      backgroundColor: AppColors.surface,
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      side: const BorderSide(color: AppColors.border),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.link,
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),

  tabBarTheme: const TabBarThemeData(
    labelColor: AppColors.textPrimary,
    unselectedLabelColor: AppColors.textSecondary,
    indicatorColor: AppColors.link,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? AppColors.link : AppColors.surface),
    checkColor: const WidgetStatePropertyAll(Colors.white),
    side: const BorderSide(color: AppColors.border, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? Colors.white : AppColors.textHint),
    trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? AppColors.link : AppColors.borderLight),
    trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusLg)),
    titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_radius),
      side: const BorderSide(color: AppColors.border),
    ),
    textStyle: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
    labelTextStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 14, color: AppColors.textPrimary)),
  ),
  menuTheme: MenuThemeData(
    style: MenuStyle(
      backgroundColor: const WidgetStatePropertyAll(AppColors.surface),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
    menuStyle: MenuStyle(
      backgroundColor: const WidgetStatePropertyAll(AppColors.surface),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    ),
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    headerBackgroundColor: AppColors.nav,
    headerForegroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusLg)),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surfaceMuted,
    selectedColor: AppColors.infoBg,
    labelStyle: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
    side: const BorderSide(color: AppColors.border),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  ),
  dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1, space: 1),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.link, linearTrackColor: Colors.transparent),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(color: AppColors.textPrimary, borderRadius: BorderRadius.circular(_radius)),
    textStyle: const TextStyle(color: Colors.white, fontSize: 12),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.textPrimary,
    contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
    behavior: SnackBarBehavior.floating,
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: AppColors.surface, surfaceTintColor: Colors.transparent),
  listTileTheme: const ListTileThemeData(iconColor: AppColors.textSecondary, textColor: AppColors.textPrimary, dense: true),
);
