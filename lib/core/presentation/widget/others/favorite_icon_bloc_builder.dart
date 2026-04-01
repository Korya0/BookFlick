import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:bookna_app/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIconBlocBuilder extends StatelessWidget {
  const FavoriteIconBlocBuilder({
    super.key,
    required this.book,
    this.iconSize = AppIconSize.s24,
  });

  final Book book;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<Book>>(
      builder: (context, favoriteBooks) {
        final favoriteCubit = context.read<FavoriteCubit>();
        final isFavorite = favoriteCubit.isFavorite(book);

        return InkWell(
          borderRadius: BorderRadius.circular(AppRadius.r24),
          onTap: () => _toggleFavorite(context, isFavorite),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryIconContainer,
            ),
            child: Icon(
              isFavorite
                  ? Icons.bookmark_added_rounded
                  : Icons.bookmark_add_rounded,
              color: isFavorite ? AppColors.activeIcon : AppColors.disabledIcon,
              size: iconSize,
            ),
          ),
        );
      },
    );
  }

  void _toggleFavorite(BuildContext context, bool isFavorite) {
    final favoriteCubit = context.read<FavoriteCubit>();
    if (isFavorite) {
      favoriteCubit.removeFromFavorites(book);
    } else {
      favoriteCubit.addToFavorites(book);
    }
  }
}
