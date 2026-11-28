import 'dart:math';
import 'package:recipes_app/data/fake_recipes.dart';
import 'package:recipes_app/models/recipe.dart';

class FakeRecipeRepository {
  final Random random = Random();

  Future<List<Recipe>> fetchRecipes() async {
    await Future.delayed(const Duration(seconds: 2));

    if (random.nextInt(3) == 0) {
      throw Exception('Չհաջողվեց բեռնել բաղադրատոմսերը');
    }

    return List<Recipe>.from(fakeRecipes);
  }
}