import 'package:my_expenses/models/expense.dart';

const List<Expense> initialExpenses = [
  Expense(
    id: '1',
    title: 'Սուրճ և բուլկի',
    amount: 1200,
    category: Category.food,
  ),
  Expense(
    id: '2',
    title: 'Ավտոբուսի տոմս',
    amount: 300,
    category: Category.transport,
  ),
  Expense(
    id: '3',
    title: 'Կինոթատրոն',
    amount: 4500,
    category: Category.entertainment,
  ),
];