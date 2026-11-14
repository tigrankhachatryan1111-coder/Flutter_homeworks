import 'package:flutter/material.dart';
import 'package:my_books/models/books_models.dart';

class BookTile extends StatelessWidget {
  final BookModels book;
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
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${book.author} , ${book.genre}'),
          if (book.rating > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < book.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}