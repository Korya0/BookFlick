import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookna_app/core/presentation/widget/custom_slider.dart';
import 'package:bookna_app/core/presentation/widget/slider_card.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_state.dart';

class SliderSection extends StatelessWidget {
  const SliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBooksCubit, SliderBooksState>(
      builder: (context, state) {
        if (state is SliderBooksLoaded) {
          return SliverToBoxAdapter(
            child: CustomSlider(
              itemBuilder: (BuildContext context, int itemIndex, _) {
                return SliderCard(
                  itemIndex: itemIndex,
                  isBook: true,
                  book: state.books[itemIndex],
                );
              },
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
