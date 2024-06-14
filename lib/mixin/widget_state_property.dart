import 'package:flutter/material.dart' show WidgetStateProperty;

mixin WidgetStatePropertyMixin {
  WidgetStateProperty<T> getProperty<T>(T property) {
    return WidgetStateProperty.resolveWith((_) => property);
  }
}
