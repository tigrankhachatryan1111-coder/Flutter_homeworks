import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final double size;
  final ValueChanged<int>? onRatingChanged; // Если передан, значит звезды интерактивные

  const StarRating({
    super.key,
    required this.rating,
    this.size = 16,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        int starNumber = index + 1;
        bool isFilled = starNumber <= rating;

        if (onRatingChanged == null) {
          // Просто показ звезд (например, в ListTile)
          return Icon(
            isFilled ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: size,
          );
        } else {
          // Интерактивные звезды (в деталях)
          return IconButton(
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(2),
            onPressed: () => onRatingChanged!(starNumber),
            icon: Icon(
              isFilled ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: size,
            ),
          );
        }
      }),
    );
  }
}