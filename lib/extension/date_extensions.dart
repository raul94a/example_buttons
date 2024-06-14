import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String? toFormat(String format, [Locale locale = const Locale('es', 'ES')]) {
    try {
      final parsedDate = DateFormat(format, locale.countryCode).format(this);
      return parsedDate;
    } catch (exception) {
      return null;
    }
  }

  ///Date in format dd.MM.yyyy
  String get toSwissDate {
    return DateFormat('dd.MM.yyyy').format(this);
  }

  ///Date in format dd/MM/yyyy
  String get toDDMMYYYY {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get toYYYYMMdd {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}

extension StringToDateTime on String {
  DateTime? fromFormat(String format) {
    try {
      final parsedDate = DateFormat(format).parse(this);
      return parsedDate;
    } catch (exception) {
      debugPrint('$exception');
      return null;
    }
  }

  ///Date in format dd.MM.yyyy
  DateTime? get toSwissDate {
    try {
      return DateFormat('dd.MM.yyyy').parse(this);
    } catch (ex) {
      return null;
    }
  }

  ///Date in format dd/MM/yyyy
  DateTime? get toDDMMYYYY {
    try {
      return DateFormat('dd/MM/yyyy').parse(this);
    } catch (ex) {
      return null;
    }
  }
}