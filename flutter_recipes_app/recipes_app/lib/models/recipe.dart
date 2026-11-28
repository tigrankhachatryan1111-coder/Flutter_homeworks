enum Difficulty {
  easy('Easy'),
  medium('Medium'),
  hard('Hard');

  final String label;

  const Difficulty(this.label);
}

class Recipe {
  final String id;
  final String name;
  final String cuisine;
  final int cookTimeMinutes;
  final Difficulty difficulty;
  final double rating;

  const Recipe({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.cookTimeMinutes,
    required this.difficulty,
    required this.rating,
  });
}