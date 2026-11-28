import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipe.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;

  const RecipeTile({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        recipe.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${recipe.cuisine} • ${recipe.cookTimeMinutes} րոպե • ${recipe.difficulty.label}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 18),
          const SizedBox(width: 4),
          Text(
            recipe.rating.toStringAsFixed(1),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}