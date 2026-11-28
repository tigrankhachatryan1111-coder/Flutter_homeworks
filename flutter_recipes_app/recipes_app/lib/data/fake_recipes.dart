import 'package:recipes_app/models/recipe.dart';

const List<Recipe> fakeRecipes = [
  Recipe(
    id: '1',
    name: 'Խորոված բանջարեղեն',
    cuisine: 'Հայկական',
    cookTimeMinutes: 25,
    difficulty: Difficulty.easy,
    rating: 4.7,
  ),
  Recipe(
    id: '2',
    name: 'Պաստա Կարբոնարա',
    cuisine: 'Իտալական',
    cookTimeMinutes: 20,
    difficulty: Difficulty.easy,
    rating: 4.8,
  ),
  Recipe(
    id: '3',
    name: 'Տոլմա խաղողի տերևով',
    cuisine: 'Հայկական',
    cookTimeMinutes: 60,
    difficulty: Difficulty.medium,
    rating: 4.9,
  ),
  Recipe(
    id: '4',
    name: 'Ռամեն հավով',
    cuisine: 'Ճապոնական',
    cookTimeMinutes: 45,
    difficulty: Difficulty.medium,
    rating: 4.6,
  ),
  Recipe(
    id: '5',
    name: 'Կրուասան կարագով',
    cuisine: 'Ֆրանսիական',
    cookTimeMinutes: 90,
    difficulty: Difficulty.hard,
    rating: 4.5,
  ),
  Recipe(
    id: '6',
    name: 'Հունական աղցան',
    cuisine: 'Հունական',
    cookTimeMinutes: 15,
    difficulty: Difficulty.easy,
    rating: 4.4,
  ),
];