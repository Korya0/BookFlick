import 'package:bookna_app/features/catalog/domain/entities/book.dart';

abstract class PopularBooksState {}

class PopularBooksInitial extends PopularBooksState {}

class PopularBooksLoading extends PopularBooksState {}

class PopularBooksLoadingMore extends PopularBooksState {
  final List<Book> books;
  PopularBooksLoadingMore(this.books);
}

class PopularBooksLoaded extends PopularBooksState {
  final List<Book> books;
  PopularBooksLoaded(this.books);
}

class PopularBooksError extends PopularBooksState {
  final String message;
  PopularBooksError(this.message);
}
