import 'package:expense_track_and_check/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_track_and_check/model/expense.dart';

class NewExpenseAdd extends StatefulWidget {
  const NewExpenseAdd({super.key, required this.addExpense});
  final void Function(Expense expense) addExpense;

  @override
  State<NewExpenseAdd> createState() => _NewExpenseAddState();
}

class _NewExpenseAddState extends State<NewExpenseAdd> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _amountcontroller = TextEditingController();
  bool _isTitleFocused = false;
  bool _isamountFocused = false;
  String? _titleErrorText;
  String? _amountErrorText;
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void initState() {
    _titlecontroller;
    _amountcontroller;
    _titlecontroller.addListener(_validateInput);
    _amountcontroller.addListener(_validateAmountInput);
    super.initState();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountcontroller
        .text); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid =
        enteredAmount == null || enteredAmount <= 0 || _amountErrorText != null;
    final titleIsValid =
        _titlecontroller.text.trim().isEmpty || _titleErrorText != null;
    if (titleIsValid || amountIsInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.addExpense(
      Expense(
        title: _titlecontroller.text,
        expenseAmount: enteredAmount,
        expenseDate: _selectedDate!,
        expenseCategory: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void _validateAmountInput() {
    final userInput = _amountcontroller.text;
    final amountRegex = RegExp(r'^[0-9]*$');

    if (userInput.isNotEmpty && !amountRegex.hasMatch(userInput)) {
      setState(() {
        _amountErrorText = kAmountInputError;
      });
      return;
    }
    setState(() {
      _amountErrorText = null;
    });
  }

  void _validateInput() {
    final userInput = _titlecontroller.text;
    final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]*$');

    if (userInput.isEmpty) {
      setState(() {
        _titleErrorText = null;
      });

      return;
    } else if (!alphanumericRegex.hasMatch(userInput)) {
      setState(() {
        _titleErrorText = kAlphaNumericError;
      });
      return;
    } else if (userInput.length > 50 + 1) {
      setState(() {
        _titleErrorText = kInputLengthError;
      });
      return;
    }

    setState(() {
      _titleErrorText = null;
    });
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = DateTime(now.year - 2, now.month);

    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: initialDate,
        lastDate: now,
        initialDate: now);

    if (picked == null) {
      setState(() {
        _selectedDate = picked;
      });
      return;
    }
    setState(() {
      _selectedDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _titlecontroller,
            decoration: InputDecoration(
              //label and labelText, both used for same purpose
              //label: Text('Title'),
              labelText: 'Title',
              errorText: _titleErrorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: _isTitleFocused
                      ? Colors.black // Active color
                      : Colors.grey, // Inactive color
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: _isTitleFocused
                      ? Colors.black // Active color
                      : Colors.grey, // Inactive color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: _titlecontroller.text.length >= 5 &&
                          _titleErrorText == null
                      ? Colors.green // 5+ chars and valid
                      : Colors
                          .black, // Focused but less than 5 chars or invalid
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            onTap: () {
              setState(() {
                _isTitleFocused = true;
              });
            },
            onTapOutside: (event) {
              setState(() {
                _isTitleFocused = false;
              });
            },
            maxLength: 50,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 11,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountcontroller,
                  decoration: InputDecoration(
                    label: const Text('Amount'),
                    errorText: _amountErrorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: _isamountFocused
                            ? Colors.black // Active color
                            : Colors.grey, // Inactive color
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: _isamountFocused
                            ? Colors.black // Active color
                            : Colors.grey, // Inactive color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: _amountErrorText == null
                            ? Colors.green // 5+ chars and valid
                            : Colors
                                .black, // Focused but less than 5 chars or invalid
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.redAccent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isamountFocused = true;
                    });
                  },
                  onTapOutside: (event) {
                    setState(() {
                      _isamountFocused = false;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () {
                    _pickDate();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                      //color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No Selected Date'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                          style: TextStyle(
                            color: _selectedDate == null
                                ? Colors.grey.shade600
                                : Colors.black,
                          ),
                        ),
                        const Icon(Icons.calendar_month),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          DropdownButtonFormField<Category>(
            value: _selectedCategory,
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase()),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'CANCEL',
                  )),
              const SizedBox(
                width: 4,
              ),
              ElevatedButton(
                  onPressed: () {
                    print('Button Getting Pressed');
                    _submitExpenseData();
                  },
                  child: const Text('SAVE EXPENSES')),
            ],
          ),
        ],
      ),
    );
  }
}
