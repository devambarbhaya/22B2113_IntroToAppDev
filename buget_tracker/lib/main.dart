import 'package:flutter/material.dart';

void main() {
  runApp(BudgetTrackerApp());
}

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Food', expenses: [
      Expense(value: 20.0, description: 'Lunch'),
      Expense(value: 30.0, description: 'Dinner'),
    ]),
    Category(name: 'Transportation', expenses: [
      Expense(value: 15.0, description: 'Bus fare'),
      Expense(value: 25.0, description: 'Gasoline'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    double totalExpenses = 0.0;
    for (var category in categories) {
      totalExpenses += category.getTotalExpenses();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, John Doe!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Total Expenses: \$${totalExpenses.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(category.name),
                  subtitle: Text('Total Expenses: \$${category.getTotalExpenses().toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpenseScreen(category: category),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final List<Expense> expenses;

  Category({required this.name, required this.expenses});

  double getTotalExpenses() {
    double totalExpenses = 0.0;
    for (var expense in expenses) {
      totalExpenses += expense.value;
    }
    return totalExpenses;
  }
}

class Expense {
  final double value;
  final String description;

  Expense({required this.value, required this.description});
}

class ExpenseScreen extends StatelessWidget {
  final Category category;

  ExpenseScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        itemCount: category.expenses.length,
        itemBuilder: (context, index) {
          final expense = category.expenses[index];
          return ListTile(
            title: Text('\$${expense.value.toStringAsFixed(2)}'),
            subtitle: Text(expense.description),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddExpensePopup(),
          );
        },
      ),
    );
  }
}

class AddExpensePopup extends StatefulWidget {
  @override
  _AddExpensePopupState createState() => _AddExpensePopupState();
}

class _AddExpensePopupState extends State<AddExpensePopup> {
  final TextEditingController valueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: valueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Value',
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final double value = double.tryParse(valueController.text) ?? 0.0;
            final String description = descriptionController.text;
            final Expense expense = Expense(value: value, description: description);
            Navigator.pop(context, expense);
          },
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
