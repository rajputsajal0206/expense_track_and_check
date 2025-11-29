import 'package:expense_track_and_check/model/expense.dart';
import 'package:expense_track_and_check/widget/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expensesList,required this.removeExpense});
  final List<Expense> expensesList;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) =>
          //expensesList[index] --> Sends Prticular expense from the list
          Dismissible(
            key: ValueKey(expensesList[index]),
            onDismissed: (DismissDirection direction){
              removeExpense(expensesList[index]);
            },
            child: ExpenseItem(
                    expense: expensesList[index],
                  ),
          ),
    );
  }
}
