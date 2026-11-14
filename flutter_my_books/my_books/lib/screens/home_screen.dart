import 'package:flutter/material.dart';
import 'package:my_books/models/books_models.dart';
import '../models/books_initial.dart';
import '../widgets/book_tile.dart';
import 'book_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<BookModels> books = List.from(booksInitial);
  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';
  String selectedGenre = 'Բոլորը';

  final List<String> genres = [
    'Բոլորը',
    'Վեպ',
    'Պատմություն',
    'Ֆանտաստիկա',
    'Բանաստեղծություն',
  ];

  int get readCount => books.where((b) => b.isRead).length;

  List<BookModels> get filteredBooks {
    return books.where((book) {
      final matchesGenre =
          selectedGenre == 'Բոլորը' || book.genre == selectedGenre;
      final query = searchQuery.toLowerCase();
      final matchesSearch = book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);

      return matchesGenre && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void deleteBook(BookModels book) {
    final int deletedIndex = books.indexOf(book);

    setState(() {
      books.removeAt(deletedIndex);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('«${book.title}» գիրքը ջնջվեց'),
        action: SnackBarAction(
          label: 'Վերադարձնել',
          onPressed: () {
            setState(() {
              books.insert(deletedIndex, book);
            });
          },
        ),
      ),
    );
  }

  Future<void> openDetails(BookModels book) async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(book: book),
      ),
    );

    if (result != null && result > 0) {
      setState(() {
        book.rating = result;
        book.isRead = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayedBooks = filteredBooks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Իմ գրքերը (${readCount} / ${books.length})'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Որոնել ըստ անվան կամ հեղինակի',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final genre = genres[index];
                return ChoiceChip(
                  label: Text(genre),
                  selected: selectedGenre == genre,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        selectedGenre = genre;
                      });
                    }
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: displayedBooks.isEmpty
                ? const Center(
                    child: Text(
                      'Ոչինչ չի գտնվել',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    itemCount: displayedBooks.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final book = displayedBooks[index];
                      return Dismissible(
                        key: ValueKey(book.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => deleteBook(book),
                        child: BookTile(
                          book: book,
                          onCheckboxChanged: (value) {
                            setState(() {
                              book.isRead = value ?? false;
                            });
                          },
                          onTap: () => openDetails(book),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}