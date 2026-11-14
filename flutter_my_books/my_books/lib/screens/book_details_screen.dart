import 'package:flutter/material.dart';
import 'package:my_books/models/books_models.dart';

class BookDetailsScreen extends StatefulWidget {
  final BookModels book;

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
              'Ժանր՝ ${widget.book.genre}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const Divider(height: 40),
            const Text(
              'Գնահատեք գիրքը (1-5 աստղ)՝',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(5, (index) {
                int starNumber = index + 1;
                return IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRating = starNumber;
                    });
                  },
                  icon: Icon(
                    starNumber <= selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 36,
                  ),
                );
              }),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedRating);
                },
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