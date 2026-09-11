import 'package:flutter/widgets.dart';

const double kDesktopBreakpoint = 900;
const double kContentMaxWidth = 1440;

bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= kDesktopBreakpoint;
