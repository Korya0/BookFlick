import 'package:bookna_app/core/api/error/exceptions.dart';
import 'package:bookna_app/core/api/network/api_constants.dart';
import 'package:bookna_app/core/api/network/error_message_model.dart';
import 'package:bookna_app/core/utils/logging/app_logger.dart';
import 'package:bookna_app/features/catalog/data/model/author_model/author_model.dart';

import 'package:bookna_app/features/catalog/domain/entities/author.dart';
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
            AppLogger.warning('⚠️ Unexpected "docs" format in author response: ${docs.runtimeType}');
            return [];
          }
        } else {
          AppLogger.error('❌ Invalid response format for author search', response.data);
          throw ServerException(
            errorMessageModel: const ErrorMessageModel(
              message: 'Invalid response format',
            ),
          );
        }
      } else {
        AppLogger.error('❌ Failed author search with Status: ${response.statusCode}');
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
    } on DioException {
      // Re-throw to be caught by repository, but logger in interceptor already active
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('❌ Parsing error in AuthorRemoteDataSource', e, stackTrace);
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          message: 'Unexpected error: ${e.toString()}',
        ),
      );
    }
  }
}
