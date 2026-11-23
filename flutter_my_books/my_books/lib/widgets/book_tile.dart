import 'package:flutter/material.dart';
import 'package:my_books/widgets/star_rating_widget.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onTap;

  const BookTile({
    super.key,
    required this.book,
    required this.onCheckboxChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Checkbox(
        value: book.isRead,
        onChanged: onCheckboxChanged,
      ),
      title: Text(
        book.title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          // Пункт 2: Название прочитанной книги зачеркивается
          decoration: book.isRead ? TextDecoration.lineThrough : null,
          color: book.isRead ? Colors.grey : Colors.black87,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${book.author} • ${book.genre.label}'),
          if (book.rating > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: StarRating(rating: book.rating, size: 16), // Пункт 6
            ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}