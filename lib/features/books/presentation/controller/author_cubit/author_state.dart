part of 'author_cubit.dart';

abstract class AuthorState {}

class AuthorInitial extends AuthorState {}

class AuthorLoading extends AuthorState {}

class AuthorLoaded extends AuthorState {
  final Author author;

  AuthorLoaded({required this.author});
}

class AuthorError extends AuthorState {
  final String message;

  AuthorError({required this.message});
}
