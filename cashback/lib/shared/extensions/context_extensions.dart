import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Text Styles
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Colors
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get backgroundColor => Theme.of(this).backgroundColor;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  // Media Query
  Size get mediaSize => MediaQuery.of(this).size;
  double get mediaWidth => MediaQuery.of(this).size.width;
  double get mediaHeight => MediaQuery.of(this).size.height;
  double get mediaAspectRatio => MediaQuery.of(this).size.aspectRatio;

  // Navigation
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Route<T> route) => Navigator.of(this).push(route);
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  Future<T?> pushReplacementNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);

  // Responsive Helpers
  bool get isMobile => mediaWidth < 600;
  bool get isTablet => mediaWidth >= 600 && mediaWidth < 1200;
  bool get isDesktop => mediaWidth >= 1200;

  double responsiveWidth(double mobile, double tablet, double desktop) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }
}
