import 'package:bookna_app/features/books/data/datasource/author_remote_data_source_impl.dart';
import 'package:bookna_app/features/books/data/datasource/books_remote_data_source.dart';
import 'package:bookna_app/features/books/data/repo/author_repository_impl.dart';
import 'package:bookna_app/features/books/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/books/domain/repo/author_repo.dart';
import 'package:bookna_app/features/books/domain/usecase/get_author_with_name_use_case.dart';
import 'package:bookna_app/features/books/domain/usecase/get_books_by_title_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/author_cubit/author_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServicesLocator() {
  // Dio
  getIt.registerLazySingleton(() => Dio());

  // Data Sources
  getIt.registerLazySingleton<AuthorRemoteDataSource>(
    () => AuthorRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<BooksRemoteDataSource>(
    () => BooksRemoteDataSourceImpl(),
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
