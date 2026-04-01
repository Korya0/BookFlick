import 'package:bookna_app/core/api/error/exceptions.dart';
import 'package:bookna_app/core/api/error/failure.dart';
import 'package:bookna_app/core/utils/logging/app_logger.dart';
import 'package:bookna_app/features/catalog/data/datasource/books_remote_data_source.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:bookna_app/features/catalog/domain/repo/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BooksRepoImpl extends BooksRepo {
  final BooksRemoteDataSource booksRemoteDataSource;

  BooksRepoImpl({required this.booksRemoteDataSource});

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final result = await booksRemoteDataSource.getBooks();
      return Right(result);
    } on ServerException catch (failure) {
      AppLogger.error('❌ Server error in getBooks', failure.errorMessageModel.message);
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      AppLogger.error('❌ Network error in getBooks', failure.message, failure.stackTrace);
      return Left(ServerFailure(failure.message));
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getBooks', e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllPopularBooks(int page) async {
    try {
      final result = await booksRemoteDataSource.getAllPopularBooks(page);
      return Right(result);
    } on ServerException catch (failure) {
      AppLogger.error('❌ Server error in getAllPopularBooks [Page $page]', failure.errorMessageModel.message);
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      AppLogger.error('❌ Network error in getAllPopularBooks [Page $page]', failure.message, failure.stackTrace);
      return Left(ServerFailure(failure.message));
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getAllPopularBooks', e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllTopRatedBooks(int page) async {
    try {
      final result = await booksRemoteDataSource.getAllTopRatedBooks(page);
      return Right(result);
    } on ServerException catch (failure) {
      AppLogger.error('❌ Server error in getAllTopRatedBooks [Page $page]', failure.errorMessageModel.message);
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      AppLogger.error('❌ Network error in getAllTopRatedBooks [Page $page]', failure.message, failure.stackTrace);
      return Left(ServerFailure(failure.message));
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getAllTopRatedBooks', e, stackTrace);
      return Left(ServerFailure(e.toString()));
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
      AppLogger.error('❌ Server error in getBooksByCategory [$category]', failure.errorMessageModel.message);
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      AppLogger.error('❌ Network error in getBooksByCategory [$category]', failure.message, failure.stackTrace);
      return Left(ServerFailure(failure.message));
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getBooksByCategory', e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBooksByTitle(String title) async {
    try {
      final result = await booksRemoteDataSource.getBooksByTitle(title);
      return Right(result);
    } on ServerException catch (failure) {
      AppLogger.error('❌ Server error in getBooksByTitle [$title]', failure.errorMessageModel.message);
      return Left(ServerFailure(failure.errorMessageModel.code.toString()));
    } on DioException catch (failure) {
      AppLogger.error('❌ Network error in getBooksByTitle [$title]', failure.message, failure.stackTrace);
      return Left(ServerFailure(failure.message));
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getBooksByTitle', e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }
}
