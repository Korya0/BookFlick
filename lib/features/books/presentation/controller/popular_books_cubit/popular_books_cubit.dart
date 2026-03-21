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
    List<Book> allBooks = [];
    const int booksLimit = 40;
    int page = 1;
    bool hasMore = true;

    while (allBooks.length < booksLimit && hasMore) {
      final result = await getAllPopularBooksUseCase(page);
      result.fold(
        (failure) {
          emit(PopularBooksError(failure.message.toString()));
          hasMore = false;
        },
        (newBooks) {
          if (newBooks.isEmpty) {
            hasMore = false;
          } else {
            allBooks.addAll(newBooks);
            page++;
          }
        },
      );
    }
    // ignore: unnecessary_this
    this.books = allBooks.take(booksLimit).toList();
    // ignore: unnecessary_this
    emit(PopularBooksLoaded(this.books));
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
