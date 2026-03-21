import 'package:bookna_app/core/data/error/exceptions.dart';
import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/core/data/network/error_message_model.dart';
import 'package:bookna_app/features/books/data/model/author_model/author_model.dart';

import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:dio/dio.dart';

abstract class AuthorRemoteDataSource {
  Future<List<Author>> getAuthorWithName(String name);
}

class AuthorRemoteDataSourceImpl implements AuthorRemoteDataSource {
  final Dio dio;

  AuthorRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Author>> getAuthorWithName(String name) async {
    try {
      final response = await dio.get(ApiConstants.getAuthorWithNamePath(name));
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          final jsonData = response.data as Map<String, dynamic>;
          final docs = jsonData['docs'];
          if (docs is List<dynamic>) {
            return docs
                // ignore: prefer_iterable_wheretype
                .where((doc) => doc is Map<String, dynamic>)
                .map((doc) => AuthorModel.fromJson(doc as Map<String, dynamic>))
                .toList();
          } else {
            return [];
          }
        } else {
          throw ServerException(
            errorMessageModel: const ErrorMessageModel(
              message: 'Invalid response format',
            ),
          );
        }
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            response.data is Map<String, dynamic>
                ? response.data
                : {
                  'message': 'Unexpected error, status: ${response.statusCode}',
                },
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          message:
              e.response?.data is Map<String, dynamic>
                  ? e.response?.data['message'] ?? 'Unknown server error'
                  : e.message ?? 'Network error',
        ),
      );
    } catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          message: 'Unexpected error: ${e.toString()}',
        ),
      );
    }
  }
}
