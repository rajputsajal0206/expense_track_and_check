import 'package:expense_track_and_check/model/expense.dart';
import 'package:expense_track_and_check/widget/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expensesList});
  final List<Expense> expensesList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expensesList.length,
        itemBuilder: (ctx, index) =>
          ExpenseItem(
            expense: expensesList[index],
          ),
        );
  }
}
