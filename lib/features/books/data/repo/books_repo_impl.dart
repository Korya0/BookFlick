import 'package:bookna_app/core/data/error/exceptions.dart';
import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/features/books/data/datasource/books_remote_data_source.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/domain/repo/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BooksRepoImpl extends BooksRepo {
  final BooksRemoteDataSource booksRemoteDataSource;

  BooksRepoImpl({required this.booksRemoteDataSource});

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final result = await booksRemoteDataSource.getMovies();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllPopularBooks(int page) async {
    try {
      final result = await booksRemoteDataSource.getAllPopularMovies(page);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllTopRatedBooks(int page) async {
    try {
      final result = await booksRemoteDataSource.getAllTopRatedMovies(page);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBooksByCategoryPath(
    String category,
  ) async {
    try {
      final result = await booksRemoteDataSource.getBooksBycategory(category);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBooksByTitle(String title) async {
    try {
      final result = await booksRemoteDataSource.getBooksByTitle(title);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }
}
