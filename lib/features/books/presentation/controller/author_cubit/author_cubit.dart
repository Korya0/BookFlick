import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:bookna_app/features/books/domain/usecase/get_author_with_name_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'author_state.dart';

class AuthorCubit extends Cubit<AuthorState> {
  final GetAuthorWithNameUseCase getAuthorWithNameUseCase;

  AuthorCubit({required this.getAuthorWithNameUseCase})
    : super(AuthorInitial());

  Future<void> fetchAuthorData(String authorName) async {
    emit(AuthorLoading());

    final Either<Failure, List<Author>> result = await getAuthorWithNameUseCase
        .call(authorName);

    result.fold(
      (failure) => emit(AuthorError(message: failure.message.toString())),
      (authors) {
        if (authors.isEmpty) {
          emit(AuthorError(message: 'No authors found'));
        } else {
          emit(AuthorLoaded(author: authors.first));
        }
      },
    );
  }
}
