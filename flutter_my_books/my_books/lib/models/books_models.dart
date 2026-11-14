class BookModels {
  final String id;
  final String title;
  final String author;
  final String genre;
  bool isRead;
  int rating;

  BookModels({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    this.isRead = false,
    this.rating = 0,
  });
}