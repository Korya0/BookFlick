
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/nice_loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view_card.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularBooksContent extends StatefulWidget {
  const PopularBooksContent({super.key});

  @override
  State<PopularBooksContent> createState() => _PopularBooksContentState();
}

class _PopularBooksContentState extends State<PopularBooksContent> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<PopularBooksCubit>().getPopularBooks(isInitialFetch: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreBooks() {
    if (!_isLoadingMore) {
      _isLoadingMore = true;
      context.read<PopularBooksCubit>().getPopularBooks().then((_) {
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
    return BlocConsumer<PopularBooksCubit, PopularBooksState>(
      listener: (context, state) {
        if (state is PopularBooksError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is PopularBooksLoading) {
          return const LoadingWidget();
        }

        final books =
            state is PopularBooksLoaded
                ? state.books
                : (state as PopularBooksLoadingMore).books;

        return Stack(
          children: [
            VerticalListView(
              controller: _scrollController,
              itemCount: books.length,
              itemBuilder:
                  (context, index) => VerticalListViewCard(book: books[index]),
              onScrollEnd: _loadMoreBooks,
              loadMoreThreshold: 0.7, // تحديد 70% هنا
            ),
            if (state is PopularBooksLoadingMore)
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
