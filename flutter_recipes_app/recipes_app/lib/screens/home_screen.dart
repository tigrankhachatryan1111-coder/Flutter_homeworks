import 'package:flutter/material.dart';
import 'package:recipes_app/data/fake_recipe_repository.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/widgets/recipe_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FakeRecipeRepository _repository = FakeRecipeRepository();
  late Future<List<Recipe>> _recipesFuture;

  Difficulty? _selectedDifficulty;

  @override
  void initState() {
    super.initState();
    _recipesFuture = _repository.fetchRecipes();
  }

  void _reloadRecipes() {
    setState(() {
      _recipesFuture = _repository.fetchRecipes();
    });
  }

  Future<void> _onRefresh() async {
    final newFuture = _repository.fetchRecipes();
    setState(() {
      _recipesFuture = newFuture;
    });
    try {
      await newFuture;
    } catch (_) {
      
    }
  }

  List<Recipe> _filterRecipes(List<Recipe> recipes) {
    if (_selectedDifficulty == null) {
      return recipes;
    }
    return recipes
        .where((recipe) => recipe.difficulty == _selectedDifficulty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Բաղադրատոմսեր'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Սխալ տեղի ունեցավ տվյալները բեռնելիս',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _reloadRecipes,
                      child: const Text('Կրկին փորձել'),
                    ),
                  ],
                ),
              ),
            );
          }

          final allRecipes = snapshot.data ?? [];
          final filteredRecipes = _filterRecipes(allRecipes);

          return Column(
            children: [
              SizedBox(
                height: 48,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ChoiceChip(
                      label: const Text('Բոլորը'),
                      selected: _selectedDifficulty == null,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedDifficulty = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Easy'),
                      selected: _selectedDifficulty == Difficulty.easy,
                      onSelected: (selected) {
                        setState(() {
                          _selectedDifficulty =
                              selected ? Difficulty.easy : null;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Medium'),
                      selected: _selectedDifficulty == Difficulty.medium,
                      onSelected: (selected) {
                        setState(() {
                          _selectedDifficulty =
                              selected ? Difficulty.medium : null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: filteredRecipes.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 120),
                            Center(
                              child: Text(
                                'Բաղադրատոմսեր չկան',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: filteredRecipes.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final recipe = filteredRecipes[index];
                            return RecipeTile(recipe: recipe);
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}