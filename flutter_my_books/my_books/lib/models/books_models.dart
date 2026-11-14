class BookModels {
  final String id;
  final String title;
  final String author;
  final String genre; // Обычная строка вместо enum
  bool isRead;
  int rating; // 0-ից 5

  BookModels({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    this.isRead = false,
    this.rating = 0,
  });
}