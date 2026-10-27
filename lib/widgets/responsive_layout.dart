import 'package:flutter/material.dart';

/// Experiment 3: Responsive UI with Breakpoints & MediaQueries
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  // Breakpoints in logical pixels
  static const double mobileMax = 650;
  static const double tabletMax = 1000;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileMax &&
      MediaQuery.of(context).size.width < tabletMax;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletMax && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= mobileMax && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}
