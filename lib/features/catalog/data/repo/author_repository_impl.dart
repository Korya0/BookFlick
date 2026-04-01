import 'package:bookna_app/core/api/error/exceptions.dart';
import 'package:bookna_app/core/api/error/failure.dart';
import 'package:bookna_app/core/utils/logging/app_logger.dart';
import 'package:bookna_app/features/catalog/data/datasource/author_remote_data_source_impl.dart';
import 'package:bookna_app/features/catalog/domain/entities/author.dart';
import 'package:bookna_app/features/catalog/domain/repo/author_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthorRepositoryImpl implements AuthorRepo {
  final AuthorRemoteDataSource authorRemoteDataSource;

  AuthorRepositoryImpl({required this.authorRemoteDataSource});

  @override
  Future<Either<Failure, List<Author>>> getAuthorWithName(String name) async {
    try {
      final result = await authorRemoteDataSource.getAuthorWithName(name);
      return Right(result);
    } on ServerException catch (e) {
      AppLogger.error('❌ Server error getting author "$name"', e.errorMessageModel.message);
      return Left(ServerFailure(e.errorMessageModel.message));
    } on DioException catch (e) {
      final message =
          e.response?.data != null
              ? 'API Error: ${e.response?.statusCode} - ${e.response?.data}'
              : e.message ?? 'Unknown network error';
      AppLogger.error('❌ Network error filtering author "$name"', message, e.stackTrace);
      return Left(ServerFailure(message));
    } catch (e, stackTrace) {
      final errorMessage = 'Unexpected error: ${e.runtimeType} - ${e.toString()}';
      AppLogger.error('❌ Unexpected error in AuthorRepository', e, stackTrace);
      return Left(ServerFailure(errorMessage));
    }
  }
}
