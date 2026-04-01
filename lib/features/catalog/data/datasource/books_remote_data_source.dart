import 'package:bookna_app/core/api/error/exceptions.dart';
import 'package:bookna_app/core/api/network/api_constants.dart';
import 'package:bookna_app/core/api/network/error_message_model.dart';
import 'package:bookna_app/core/utils/logging/app_logger.dart';
import 'package:bookna_app/features/catalog/data/model/book_model/book_model.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:dio/dio.dart';

abstract class BooksRemoteDataSource {
  Future<List<Book>> getBooks();
  Future<List<Book>> getAllPopularBooks(int page);
  Future<List<Book>> getAllTopRatedBooks(int page);
  Future<List<Book>> getBooksBycategory(String category);
  Future<List<Book>> getBooksByTitle(String title);
}

class BooksRemoteDataSourceImpl extends BooksRemoteDataSource {
  final Dio _dio;

  BooksRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Book>> getBooks() async {
    try {
      final response = await _dio.get(ApiConstants.getNewestBooksPath);
      if (response.statusCode == 200) {
        List<Book> books = getBooksList(response.data);
        return books;
      } else {
        AppLogger.error('❌ Failed getBooks with Status: ${response.statusCode}');
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getBooks datasource', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Book>> getAllPopularBooks(int page) async {
    try {
      final response = await _dio.get(ApiConstants.getPopularBooksPath(page));
      if (response.statusCode == 200) {
        List<Book> books = getBooksList(response.data);
        return books;
      } else {
        AppLogger.error('❌ Failed getAllPopularBooks with Status: ${response.statusCode}');
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getAllPopularBooks datasource', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Book>> getAllTopRatedBooks(int page) async {
    try {
      final response = await _dio.get(ApiConstants.getTopRatedBooksPath(page));
      if (response.statusCode == 200) {
        List<Book> books = getBooksList(response.data);
        return books;
      } else {
        AppLogger.error('❌ Failed getAllTopRatedBooks with Status: ${response.statusCode}');
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getAllTopRatedBooks datasource', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Book>> getBooksBycategory(String category) async {
    try {
      final response = await _dio.get(
        ApiConstants.getBooksByCategoryPath(category),
      );
      if (response.statusCode == 200) {
        List<Book> books = getBooksList(response.data);
        return books;
      } else {
        AppLogger.error('❌ Failed getBooksByCategory with Status: ${response.statusCode}');
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getBooksByCategory datasource', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Book>> getBooksByTitle(String title) async {
    try {
      final response = await _dio.get(ApiConstants.getBooksByTitlePath(title));
      if (response.statusCode == 200) {
        List<Book> books = getBooksList(response.data);
        return books;
      } else {
        AppLogger.error('❌ Failed getBooksByTitle with Status: ${response.statusCode}');
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error in getBooksByTitle datasource', e, stackTrace);
      rethrow;
    }
  }
}

List<Book> getBooksList(Map<String, dynamic> data) {
  try {
    List<Book> books = [];
    // Safely handle null 'items' field
    final items = data['items'] as List<dynamic>? ?? [];
    for (var bookMap in items) {
      books.add(BookModel.fromJson(bookMap as Map<String, dynamic>));
    }
    return books;
  } catch (e, stackTrace) {
    AppLogger.error('❌ Parsing error in getBooksList', e, stackTrace);
    return [];
  }
}
