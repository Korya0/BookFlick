import 'package:bookna_app/core/di/di_locator.dart';
import 'package:bookna_app/core/resources/constants/app_strings.dart';
import 'package:bookna_app/features/catalog/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/catalog/domain/usecase/get_all_popular_books_use_case.dart';
import 'package:bookna_app/features/catalog/domain/usecase/get_all_top_rated_books_use_case.dart';
import 'package:bookna_app/features/catalog/domain/usecase/get_books_by_category_path_use_case.dart';
import 'package:bookna_app/features/catalog/domain/usecase/get_books_use_case.dart';
import 'package:bookna_app/features/catalog/presentation/controller/books_cubit/books_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/similar_cubit/similar_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:bookna_app/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocProviders extends StatelessWidget {
  final Widget child;
  const GlobalBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => SimilarCubit(
                GetBooksByCategoryPathUseCase(getIt.get<BooksRepoImpl>()),
              ),
        ),
        BlocProvider(create: (context) => FavoriteCubit()),
        BlocProvider(
          create: (context) {
            final cubit = SliderBooksCubit(
              GetBooksUseCase(getIt.get<BooksRepoImpl>()),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getSliderBooks().catchError((e) {
                debugPrint('${AppStrings.sliderBooksError}  $e');
              });
            });
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = PopularBooksCubit(
              GetAllPopularBooksUseCase(getIt.get<BooksRepoImpl>()),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getPopularBooksLimited().catchError((e) {
                debugPrint('${AppStrings.popularBooksError}  $e');
              });
            });
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = TopRatedBooksCubit(
              GetAllTopRatedBooksUseCase(getIt.get<BooksRepoImpl>()),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getTopRatedBooksLimited().catchError((e) {
                debugPrint('${AppStrings.topRatedBooksError} $e');
              });
            });
            return cubit;
          },
        ),
      ],
      child: child,
    );
  }
}
