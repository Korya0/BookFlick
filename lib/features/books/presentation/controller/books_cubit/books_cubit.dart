import 'package:bookna_app/core/domain/usecase/base_use_case.dart';
import 'package:bookna_app/features/books/domain/usecase/get_books_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderBooksCubit extends Cubit<SliderBooksState> {
  final GetBooksUseCase getBooksUseCase;

  SliderBooksCubit(this.getBooksUseCase) : super(SliderBooksInitial());

  Future<void> getSliderBooks() async {
    emit(SliderBooksLoading());
    final result = await getBooksUseCase(NoParameters());
    result.fold(
      (failure) => emit(SliderBooksError(failure.message.toString())),
      (books) => emit(SliderBooksLoaded(books)),
    );
  }
}
