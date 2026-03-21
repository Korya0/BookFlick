import 'package:bookna_app/features/books/domain/entities/book.dart';

abstract class SearchState {
  const SearchState();
}

class SearchBooksInitial extends SearchState {
  const SearchBooksInitial();
}

class SearchBooksLoading extends SearchState {
  const SearchBooksLoading();
}

class SearchBooksLoaded extends SearchState {
  final List<Book> books;

  const SearchBooksLoaded(this.books);
}

class SearchBooksError extends SearchState {
  final String message;

  const SearchBooksError(this.message);
}
