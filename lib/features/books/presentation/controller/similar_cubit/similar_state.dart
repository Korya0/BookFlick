import 'package:bookna_app/features/books/domain/entities/book.dart';

abstract class SimilarState {}

class SimilarBooksInitial extends SimilarState {}

class SimilarBooksLoading extends SimilarState {}

class SimilarBooksLoaded extends SimilarState {
  final List<Book> books;
  SimilarBooksLoaded(this.books);
}

class SimilarBooksError extends SimilarState {
  final String message;
  SimilarBooksError(this.message);
}

class SimilarBooksLoadingMore extends SimilarState {
  final List<Book> books;
  SimilarBooksLoadingMore(this.books);
}
