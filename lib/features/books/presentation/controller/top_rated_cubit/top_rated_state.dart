import 'package:bookna_app/features/books/domain/entities/book.dart';

abstract class TopRatedBooksState {}

class TopRatedBooksInitial extends TopRatedBooksState {}

class TopRatedBooksLoading extends TopRatedBooksState {}

class TopRatedBooksLoadingMore extends TopRatedBooksState {
  final List<Book> books;
  TopRatedBooksLoadingMore(this.books);
}

class TopRatedBooksLoaded extends TopRatedBooksState {
  final List<Book> books;
  TopRatedBooksLoaded(this.books);
}

class TopRatedBooksError extends TopRatedBooksState {
  final String message;
  TopRatedBooksError(this.message);
}
