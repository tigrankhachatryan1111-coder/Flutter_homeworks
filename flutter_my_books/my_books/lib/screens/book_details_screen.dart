import 'package:flutter/material.dart';
import 'package:my_books/widgets/star_rating_widget.dart';
import '../models/book.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late int selectedRating;

  @override
  void initState() {
    super.initState();
    selectedRating = widget.book.rating;
  }

  @override
  Widget build(BuildContext context) {
    // Пункт 8: Проверка, выбрана ли оценка (должна быть > 0)
    bool canSave = selectedRating > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Գրքի մասին'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Հեղինակ՝ ${widget.book.author}',
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              'Ժանր՝ ${widget.book.genre.label}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const Divider(height: 40),
            const Text(
              'Գնահատեք գիրքը (1-5 աստղ)՝',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            // Пункт 6: Используем общий виджет StarRating с возможностью выбора
            StarRating(
              rating: selectedRating,
              size: 36,
              onRatingChanged: (newRating) {
                setState(() {
                  selectedRating = newRating;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                // Пункт 8: Если оценка не выбрана (0), кнопка отключена (null)
                onPressed: canSave
                    ? () {
                        Navigator.pop(context, selectedRating);
                      }
                    : null,
                child: const Text(
                  'Պահպանել',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}