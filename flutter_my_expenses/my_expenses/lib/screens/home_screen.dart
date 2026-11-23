import 'package:flutter/material.dart';
import 'package:my_expenses/data/initial_expenses.dart';
import 'package:my_expenses/models/expense.dart';
import 'package:my_expenses/widgets/expense_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = List.from(initialExpenses);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Category _selectedAddCategory = Category.food;
  Category? _selectedFilterCategory; // null նշանակում է «Բոլորը»

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  List<Expense> get _visibleExpenses {
    if (_selectedFilterCategory == null) {
      return _expenses;
    }
    return _expenses
        .where((expense) => expense.category == _selectedFilterCategory)
        .toList();
  }

  int get _totalAmount {
    return _visibleExpenses.fold(0, (sum, item) => sum + item.amount);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _addExpense() {
    final title = _titleController.text.trim();
    final amount = int.tryParse(_amountController.text.trim());

    if (title.isEmpty) {
      _showError('Մուտքագրեք ծախսի անվանումը');
      return;
    }

    if (amount == null || amount <= 0) {
      _showError('Գումարը պետք է լինի վավեր թիվ');
      return;
    }

    final newExpense = Expense(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: _selectedAddCategory,
    );

    setState(() {
      _expenses.add(newExpense);
      _titleController.clear();
      _amountController.clear();
    });
  }

  void _deleteExpense(Expense expense) {
    final index = _expenses.indexOf(expense);
    if (index == -1) return;

    setState(() {
      _expenses.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('«${expense.title}» ծախսը ջնջվեց'),
        action: SnackBarAction(
          label: 'Վերադարձնել',
          onPressed: () {
            setState(() {
              _expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleExpenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ընդամենը՝ $_totalAmount դր.'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Անվանում',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Գումար',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: Category.values.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = Category.values[index];
                      return ChoiceChip(
                        label: Text('${category.emoji} ${category.label}'),
                        selected: _selectedAddCategory == category,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedAddCategory = category;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _addExpense,
                    child: const Text('Ավելացնել'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          SizedBox(
            height: 46,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: [
                ChoiceChip(
                  label: const Text('Բոլորը'),
                  selected: _selectedFilterCategory == null,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedFilterCategory = null;
                      });
                    }
                  },
                ),
                const SizedBox(width: 8),
                ...Category.values.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text('${category.emoji} ${category.label}'),
                      selected: _selectedFilterCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilterCategory = selected ? category : null;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text(
                      'Ծախսեր չկան',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final expense = visible[index];
                      return Dismissible(
                        key: ValueKey(expense.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => _deleteExpense(expense),
                        child: ExpenseTile(expense: expense),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}