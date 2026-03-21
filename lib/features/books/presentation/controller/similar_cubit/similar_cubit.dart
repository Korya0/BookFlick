import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/domain/usecase/get_books_by_category_path_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarCubit extends Cubit<SimilarState> {
  final GetBooksByCategoryPathUseCase _getBooksByCategoryUseCase;

  List<Book> books = [];
  int currentPage = 1;
  bool hasMoreData = true;
  String? currentCategory;
  bool isLoadingMore = false;

  SimilarCubit(this._getBooksByCategoryUseCase) : super(SimilarBooksInitial());

  Future<void> fetchBooksByCategory(
    String category, {
    bool isInitial = false,
  }) async {
    if ((isLoadingMore || !hasMoreData) && !isInitial) return;

    if (isInitial || currentCategory != category) {
      books.clear();
      currentPage = 1;
      hasMoreData = true;
      currentCategory = category;
      emit(SimilarBooksLoading());
    } else {
      isLoadingMore = true;
      emit(SimilarBooksLoadingMore(books));
    }

    final result = await _getBooksByCategoryUseCase(category);

    result.fold(
      (failure) {
        emit(SimilarBooksError(failure.message.toString()));
        isLoadingMore = false;
      },
      (newBooks) {
        isLoadingMore = false;
        books.addAll(newBooks);
        currentPage++;
        hasMoreData = newBooks.isNotEmpty;
        emit(SimilarBooksLoaded(books));
      },
    );
  }

  Future<void> refresh() async {
    if (currentCategory != null) {
      await fetchBooksByCategory(currentCategory!, isInitial: true);
    }
  }
}
