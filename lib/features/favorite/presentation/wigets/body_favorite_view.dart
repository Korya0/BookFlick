import 'package:bookna_app/core/presentation/widget/vertical_list_view.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view_card.dart';
import 'package:bookna_app/core/utils/functions/functions.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:bookna_app/features/favorite/presentation/wigets/empty_favorite_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyFavoriteView extends StatelessWidget {
  const BodyFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<Book>>(
      builder: (context, favoriteBooks) {
        if (favoriteBooks.isEmpty) {
          return const Center(child: EmptyFavoriteText());
        }
        return VerticalListView(
          itemCount: favoriteBooks.length,
          itemBuilder:
              (context, index) =>
                  VerticalListViewCard(book: favoriteBooks[index]),
          onScrollEnd: () => fetchMoreBooks(context),
        );
      },
    );
  }
}
