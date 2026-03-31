import 'package:hive/hive.dart';
part 'book.g.dart';
@HiveType(typeId: 0)
class Book {
  @HiveField(1)
  final String? bookId;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final List<String>? authors;
  @HiveField(4)
  final String? publishedDate;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final num? pageCount;
  @HiveField(7)
  final num? price;
  @HiveField(8)
  final num? averageRating;
  @HiveField(9)
  final num? ratingsCount;
  @HiveField(10)
  final String thumbnail;
  @HiveField(11)
  final List<String>? categories;
  @HiveField(12)
  final String? previewLink;

  Book({
    required this.bookId,
    required this.title,
    required this.authors,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.price,
    required this.averageRating,
    required this.ratingsCount,
    required this.thumbnail,
    required this.categories,
    required this.previewLink,
  });
}
