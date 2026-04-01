import 'package:bookna_app/core/api/network/api_interceptor.dart';
import 'package:bookna_app/core/network/connectivity_service.dart';
import 'package:bookna_app/core/storage/hive_storage_service.dart';
import 'package:bookna_app/core/storage/storage_service.dart';
import 'package:bookna_app/features/catalog/data/datasource/author_remote_data_source_impl.dart';
import 'package:bookna_app/features/catalog/data/datasource/books_remote_data_source.dart';
import 'package:bookna_app/features/catalog/data/repo/author_repository_impl.dart';
import 'package:bookna_app/features/catalog/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/catalog/domain/repo/author_repo.dart';
import 'package:bookna_app/features/catalog/domain/usecase/get_author_with_name_use_case.dart';
import 'package:bookna_app/features/catalog/domain/usecase/get_books_by_title_use_case.dart';
import 'package:bookna_app/features/catalog/presentation/controller/author_cubit/author_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServicesLocator() {
  // Storage
  getIt.registerLazySingleton<IStorageService>(() => HiveStorageService());

  // Network Connectivity
  getIt.registerLazySingleton<IConnectivityService>(() => ConnectivityServiceImpl());

  // Dio
  getIt.registerLazySingleton(() {
    final dio = Dio();
    dio.interceptors.add(ApiInterceptor());
    return dio;
  });

  // Data Sources
  getIt.registerLazySingleton<AuthorRemoteDataSource>(
    () => AuthorRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<BooksRemoteDataSource>(
    () => BooksRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthorRepo>(
    () => AuthorRepositoryImpl(authorRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<BooksRepoImpl>(
    () => BooksRepoImpl(booksRemoteDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetAuthorWithNameUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBooksByTitleUseCase(getIt()));
  // Cubits
  getIt.registerFactory(() => AuthorCubit(getAuthorWithNameUseCase: getIt()));
}
