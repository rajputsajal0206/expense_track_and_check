import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum Category { food, leisure, travel, work }

const uuid = Uuid();

class Expense {
  Expense(
      {required this.title,
      required this.expenseAmount,
      required this.expenseCategory,
      required this.expenseDate})
      : id = uuid.v4();

  final String id;
  final String title;
  final double expenseAmount;
  final Category expenseCategory;
  final DateTime expenseDate;

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(expenseDate);
  }
}

Map<Category, IconData?> categoryIconsMapping = {
  Category.travel: _getCategoryIcons(Category.travel),
  Category.food: _getCategoryIcons(Category.food),
  Category.leisure: _getCategoryIcons(Category.leisure),
  Category.work: _getCategoryIcons(Category.work),
};

IconData? _getCategoryIcons(Category category) {
  if (category == Category.travel) {
    return Icons.flight_takeoff;
  } else if (category == Category.food) {
    return Icons.dining;
  } else if (category == Category.leisure) {
    return Icons.movie;
  }

  return Icons.work;
}
