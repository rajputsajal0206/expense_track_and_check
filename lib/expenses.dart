import 'package:expense_track_and_check/new_expense_add.dart';
import 'package:expense_track_and_check/widget/expense_list.dart';
import 'package:flutter/material.dart';

import 'model/expense.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<Expense> _expensesList = [
    Expense(
        title: 'Shoes',
        expenseAmount: 2500,
        expenseCategory: Category.leisure,
        expenseDate: DateTime.now()),
    Expense(
        title: 'Train',
        expenseAmount: 1800,
        expenseCategory: Category.travel,
        expenseDate: DateTime.now())
  ];

  void _addExpenses(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);
    setState(() {
      _expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expesnse is successfully removed'),
      action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRACK and CHECK EXPENSE',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                openNewExpenseModal(context, _addExpenses);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 220, 189, 252),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: <Widget>[
            const Text('We will Place CHART here'),
            Expanded(
              child: _expensesList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'No Expense added yet. Click ADD EXPENSE to add new expense'),
                          const SizedBox(
                            height: 4,
                          ),
                          TextButton(
                              onPressed: () {
                                openNewExpenseModal(context, _addExpenses);
                              },
                              child: const Text('ADD EXPENSE'))
                        ],
                      ),
                    )
                  : ExpenseList(
                      expensesList: _expensesList,
                      removeExpense: _removeExpense,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void openNewExpenseModal(BuildContext context, Function(Expense) addExpense) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (ctx) => NewExpenseAdd(
      addExpense: addExpense,
    ),
  );
}
