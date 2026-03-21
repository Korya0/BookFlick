import 'package:bookna_app/core/data/error/exceptions.dart';
import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/core/data/network/error_message_model.dart';
import 'package:bookna_app/features/books/data/model/book_model/book_model.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:dio/dio.dart';

abstract class BooksRemoteDataSource {
  Future<List<Book>> getMovies();
  Future<List<Book>> getAllPopularMovies(int page);
  Future<List<Book>> getAllTopRatedMovies(int page);
  Future<List<Book>> getBooksBycategory(String category);
  Future<List<Book>> getBooksByTitle(String title);
}

class BooksRemoteDataSourceImpl extends BooksRemoteDataSource {
  @override
  Future<List<Book>> getMovies() async {
    final response = await Dio().get(ApiConstants.getNewestBooksPath);
    if (response.statusCode == 200) {
      List<Book> books = getBooksList(response.data);
      return books;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<Book>> getAllPopularMovies(int page) async {
    final response = await Dio().get(ApiConstants.getPopularBooksPath(page));
    if (response.statusCode == 200) {
      List<Book> books = getBooksList(response.data);
      return books;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<Book>> getAllTopRatedMovies(int page) async {
    final response = await Dio().get(ApiConstants.getTopRatedBooksPath(page));
    if (response.statusCode == 200) {
      List<Book> books = getBooksList(response.data);
      return books;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<Book>> getBooksBycategory(String category) async {
    final response = await Dio().get(
      ApiConstants.getBooksByCategoryPath(category),
    );
    if (response.statusCode == 200) {
      List<Book> books = getBooksList(response.data);
      return books;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<Book>> getBooksByTitle(String title) async {
    final response = await Dio().get(ApiConstants.getBooksByTitlePath(title));
    if (response.statusCode == 200) {
      List<Book> books = getBooksList(response.data);
      return books;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}

List<Book> getBooksList(Map<String, dynamic> data) {
  List<Book> books = [];
  // Safely handle null 'items' field
  final items = data['items'] as List<dynamic>? ?? [];
  for (var bookMap in items) {
    books.add(BookModel.fromJson(bookMap as Map<String, dynamic>));
  }
  return books;
}
