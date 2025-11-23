import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum Category { food, leisure, travel, work}

const uuid = Uuid();
class Expense {

  Expense({
    required this.title,
    required this.expenseAmount,
    required this.expenseCategory,
    required this.expenseDate
}) : id= uuid.v4();

  final String id;
  final String title;
  final double expenseAmount;
  final Category expenseCategory;
  final DateTime expenseDate;

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(expenseDate);
  }
}