import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/domain/usecase/get_all_popular_books_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularBooksCubit extends Cubit<PopularBooksState> {
  final GetAllPopularBooksUseCase getAllPopularBooksUseCase;
  List<Book> books = [];
  int currentPage = 1;
  bool hasMoreData = true;

  PopularBooksCubit(this.getAllPopularBooksUseCase)
    : super(PopularBooksInitial());

  Future<void> getPopularBooksLimited() async {
    emit(PopularBooksLoading());
    const int booksLimit = 40;

    final result = await getAllPopularBooksUseCase(1);
    result.fold(
      (failure) {
        emit(PopularBooksError(failure.message.toString()));
      },
      (newBooks) {
        books = newBooks.take(booksLimit).toList();
        emit(PopularBooksLoaded(books));
      },
    );
  }

  Future<void> getPopularBooks({bool isInitialFetch = false}) async {
    if (!hasMoreData && !isInitialFetch) return;

    if (isInitialFetch) {
      books.clear();
      currentPage = 1;
      hasMoreData = true;
      emit(PopularBooksLoading());
    } else {
      emit(PopularBooksLoadingMore(books));
    }

    final result = await getAllPopularBooksUseCase(currentPage);
    result.fold(
      (failure) => emit(PopularBooksError(failure.message.toString())),
      (List<Book> newBooks) {
        if (newBooks.isEmpty) {
          hasMoreData = false;
          emit(PopularBooksLoaded(books));
        } else {
          books.addAll(newBooks);
          currentPage++;
          emit(PopularBooksLoaded(books));
        }
      },
    );
  }
}
