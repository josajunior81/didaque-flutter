class Book {
  final String bookName;
  final String bookId;
  final String bookOrder;
  final String chapterId;
  final String chapterTitle;
  final String verseId;
  final String verseText;
  final String paragraphNumber;

  Book({this.bookId, this.bookName, this.bookOrder, this.chapterId, this.chapterTitle, this.paragraphNumber, this.verseId, this.verseText});

  Book.fromJson(Map<String, dynamic> data) :
        bookOrder = data['book_order'],
        bookName = data['book_name'],
        bookId = data['book_id'],
        chapterId = data['chapter_id'],
        chapterTitle = data['chapter_title'],
        verseId = data['verse_id'],
        verseText = data['verse_text'],
        paragraphNumber = data['paragraph_number'];

  Map<String, dynamic> toJson() =>  {
      'book_order': bookOrder,
      'book_order': bookName,
      'book_id': bookId,
      'chapter_id': chapterId,
      'chapter_title': chapterTitle,
      'verse_id': verseId,
      'verse_text': verseText,
      'paragraph_number': paragraphNumber
  };
}

class Bible {
  final String volume;
  List<Book> books;

  Bible({this.books, this.volume});

  factory Bible.fromJson(Map<String, dynamic> data) {
    var l = data['books'] as List;
    List<Book> books = l.map((i) => Book.fromJson(i)).toList();
    return Bible(
        volume: data['volume'],
        books: books);
  }

  Map<String, dynamic> toJson() =>  {
    'volume': volume,
    'books': books
  };
}