import 'package:flutter/material.dart';

extension BuildContextExtensionTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle get bodySmall => textTheme.bodySmall!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get labelSmall => textTheme.labelSmall!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get titleSmall => textTheme.titleSmall!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleLarge => textTheme.titleLarge!;
}

extension BuildContextExtensionSize on BuildContext {
  Size getSize() => MediaQuery.of(this).size;
  double get width => getSize().width;
  double get height => getSize().height;

  double get availableHeight {
    MediaQueryData media = MediaQuery.of(this);
    double paddingTop = media.padding.top;
    //   double insets = media.viewInsets.top;
    return height - (paddingTop + kToolbarHeight);
  }
}

extension ContextNavigation on BuildContext {
  Future<T?> push<T extends Object?>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  Future<T?> pushReplacement<T extends Object?>(Widget page) {
    return Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  Future<T?> pushNamed<T extends Object?>(String name, T arguments) {
    return Navigator.of(this).pushNamed(name, arguments: arguments);
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      String name, T arguments) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(name, (route) => false, arguments: arguments);
  }

  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.of(this)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => page), (route) {
      return false;
    });
  }
}
