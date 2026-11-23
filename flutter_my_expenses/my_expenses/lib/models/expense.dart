enum Category {
  food('սնունդ', '🍔'),
  transport('տրանսպորտ', '🚌'),
  entertainment('զվարճանք', '🎮'),
  other('այլ', '📦');

  final String label;
  final String emoji;

  const Category(this.label, this.emoji);
}

class Expense {
  final String id;
  final String title;
  final int amount;
  final Category category;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
  });
}