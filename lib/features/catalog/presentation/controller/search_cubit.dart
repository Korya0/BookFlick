import 'package:bookna_app/features/catalog/domain/usecase/get_books_by_title_use_case.dart';
import 'package:bookna_app/features/catalog/presentation/controller/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetBooksByTitleUseCase getBooksByTitleUseCase;

  SearchCubit(this.getBooksByTitleUseCase) : super(const SearchBooksInitial());

  Future<void> getBooksByTitle(String title) async {
    if (title.isEmpty) {
      emit(const SearchBooksInitial());
      return;
    }

    emit(const SearchBooksLoading());

    final result = await getBooksByTitleUseCase(title);

    result.fold(
      (failure) => emit(SearchBooksError(failure.message.toString())),
      (books) => emit(SearchBooksLoaded(books)),
    );
  }
}
