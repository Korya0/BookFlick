import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/domain/usecase/get_all_top_rated_books_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedBooksCubit extends Cubit<TopRatedBooksState> {
  final GetAllTopRatedBooksUseCase getAllTopRatedBooksUseCase;
  List<Book> books = [];
  int currentPage = 1;
  bool hasMoreData = true;

  TopRatedBooksCubit(this.getAllTopRatedBooksUseCase)
    : super(TopRatedBooksInitial());

  Future<void> getTopRatedBooksLimited([int page = 1]) async {
    emit(TopRatedBooksLoading());
    List<Book> allBooks = [];
    const int booksLimit = 40;
    bool hasMore = true;

    while (allBooks.length < booksLimit && hasMore) {
      final result = await getAllTopRatedBooksUseCase(page);
      result.fold(
        (failure) {
          emit(TopRatedBooksError(failure.message.toString()));
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
    emit(TopRatedBooksLoaded(this.books));
  }

  Future<void> getTopRatedBooks({bool isInitialFetch = false}) async {
    if (!hasMoreData && !isInitialFetch) return;

    if (isInitialFetch) {
      books.clear();
      currentPage = 1;
      hasMoreData = true;
      emit(TopRatedBooksLoading());
    } else {
      emit(TopRatedBooksLoadingMore(books));
    }

    final result = await getAllTopRatedBooksUseCase(currentPage);
    result.fold(
      (failure) => emit(TopRatedBooksError(failure.message.toString())),
      (List<Book> newBooks) {
        if (newBooks.isEmpty) {
          hasMoreData = false;
          emit(TopRatedBooksLoaded(books));
        } else {
          books.addAll(newBooks);
          currentPage++;
          emit(TopRatedBooksLoaded(books));
        }
      },
    );
  }
}
