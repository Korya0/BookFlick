
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/nice_loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view_card.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedBooksContent extends StatefulWidget {
  const TopRatedBooksContent({super.key});

  @override
  State<TopRatedBooksContent> createState() => _TopRatedBooksContentState();
}

class _TopRatedBooksContentState extends State<TopRatedBooksContent> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<TopRatedBooksCubit>().getTopRatedBooks(isInitialFetch: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreBooks() {
    if (!_isLoadingMore) {
      _isLoadingMore = true;
      context.read<TopRatedBooksCubit>().getTopRatedBooks().then((_) {
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopRatedBooksCubit, TopRatedBooksState>(
      listener: (context, state) {
        if (state is TopRatedBooksError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is TopRatedBooksLoading) {
          return const LoadingWidget();
        }

        final books =
            state is TopRatedBooksLoaded
                ? state.books
                : (state as TopRatedBooksLoadingMore).books;

        return Stack(
          children: [
            VerticalListView(
              controller: _scrollController,
              itemCount: books.length,
              itemBuilder:
                  (context, index) => VerticalListViewCard(book: books[index]),
              onScrollEnd: _loadMoreBooks,
              loadMoreThreshold: 0.7,
            ),
            if (state is TopRatedBooksLoadingMore)
              const Positioned(
                bottom: 16.0,
                left: 0,
                right: 0,
                child: NiceLoadingWidget(),
              ),
          ],
        );
      },
    );
  }
}
