import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/views/error_page.dart';
import 'package:bookna_app/core/presentation/widget/cards/vertical_card/vertical_list_view_card.dart';
import 'package:bookna_app/core/presentation/widget/loading/loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/loading/nice_loading_widget.dart';
import 'package:bookna_app/features/catalog/presentation/controller/similar_cubit/similar_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/similar_cubit/similar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBooksList extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const CategoryBooksList({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SimilarCubit>();
    return BlocBuilder<SimilarCubit, SimilarState>(
      builder: (context, state) {
        if (state is SimilarBooksLoading && cubit.books.isEmpty) {
          return _buildLoading();
        }
        if (state is SimilarBooksError && cubit.books.isEmpty) {
          return _buildError(state.message);
        }
        return _buildSliverList(cubit);
      },
    );
  }

  Widget _buildLoading() =>
      const SliverFillRemaining(child: Center(child: LoadingWidget()));

  Widget _buildError(String message) => SliverFillRemaining(
    child: ErrorPage(message: message, onRetry: onRefresh),
  );

  Widget _buildSliverList(SimilarCubit cubit) => SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      if (index < cubit.books.length) return _buildBookCard(cubit.books[index]);
      if (cubit.hasMoreData) return _buildPaginationLoading();
      return const SizedBox();
    }, childCount: cubit.books.length + (cubit.hasMoreData ? 1 : 0)),
  );

  Widget _buildBookCard(dynamic book) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppPadding.p16,
      vertical: AppPadding.p8,
    ),
    child: VerticalListViewCard(book: book),
  );

  Widget _buildPaginationLoading() => const Padding(
    padding: EdgeInsets.all(AppPadding.p16),
    child: Center(child: NiceLoadingWidget()),
  );
}
