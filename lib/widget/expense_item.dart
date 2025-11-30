import 'package:expense_track_and_check/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final amountString = expense.expenseAmount.toStringAsFixed(2);
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'Rs.$amountString',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Icon(
                categoryIconsMapping[expense.expenseCategory],
                color: Colors.black12,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                expense.formattedDate,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )
        ],
      ),
    ));
  }
}
