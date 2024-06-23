import 'package:flutter/material.dart';

DateTime firstWeekDate(DateTime date) {
  final weekDay = date.weekday;
  final firstWeekDate = date.subtract(Duration(days: weekDay));
  return firstWeekDate;
}
