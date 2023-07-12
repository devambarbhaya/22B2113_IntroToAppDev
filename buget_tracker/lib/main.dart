import 'package:flutter/material.dart';

void main() {
  runApp(const BudgetTrackerApp());
}

class BudgetTrackerApp extends StatelessWidget {
  const BudgetTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
      ),
      body: const Column(
        children: [
          UserInfo(),
          ExpenseTotal(),
          CategoryList(),
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text('User Information'),
    );
  }
}

class ExpenseTotal extends StatelessWidget {
  const ExpenseTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text('Expense Total'),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          CategoryItem(name: 'Category 1'),
          CategoryItem(name: 'Category 2'),
          CategoryItem(name: 'Category 3'),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;

  CategoryItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseScreen(categoryName: name),
          ),
        );
      },
    );
  }
}

class ExpenseScreen extends StatelessWidget {
  final String categoryName;

  ExpenseScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: const Column(
        children: [
          ExpenseList(),
          AddExpenseButton(),
        ],
      ),
    );
  }
}

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ExpenseItem(value: 10, description: 'Expense 1'),
          ExpenseItem(value: 20, description: 'Expense 2'),
          ExpenseItem(value: 30, description: 'Expense 3'),
        ],
      ),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final double value;
  final String description;

  ExpenseItem({super.key, required this.value, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(description),
      subtitle: Text('Value: \$${value.toStringAsFixed(2)}'),
    );
  }
}

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AddExpensePopup(),
        );
      },
      child: const Text('Add Expense'),
    );
  }
}

class AddExpensePopup extends StatelessWidget {
  const AddExpensePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Expense'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Value'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Add expense logic
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}