import 'package:bookna_app/features/books/domain/entities/book.dart';

abstract class SliderBooksState {}

class SliderBooksInitial extends SliderBooksState {}

class SliderBooksLoading extends SliderBooksState {}

class SliderBooksLoaded extends SliderBooksState {
  final List<Book> books;
  SliderBooksLoaded(this.books);
}

class SliderBooksError extends SliderBooksState {
  final String message;
  SliderBooksError(this.message);
}
