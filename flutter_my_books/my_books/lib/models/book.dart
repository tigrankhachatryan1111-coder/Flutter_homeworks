enum Genre {
  all('Բոլորը'),
  novel('Վեպ'),
  history('Պատմություն'),
  fantasy('Ֆանտաստիկա'),
  poetry('Բանաստեղծություն');

  final String label;
  const Genre(this.label);
}

class Book {
  final String id;
  final String title;
  final String author;
  final Genre genre;
  bool isRead;
  int rating;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    this.isRead = false,
    this.rating = 0,
  });
}