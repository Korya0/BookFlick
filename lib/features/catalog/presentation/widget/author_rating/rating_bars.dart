import 'package:flutter/material.dart';
import 'package:bookna_app/features/catalog/presentation/widget/author_rating/rating_bar_item.dart';

class RatingBars extends StatelessWidget {
  final int ratingCount;
  final List<int> ratingDistribution;
  final Duration duration;
  final Curve curve;

  const RatingBars({
    super.key,
    required this.ratingCount,
    required this.ratingDistribution,
    required this.duration,
    required this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        final stars = 5 - index;
        final count = ratingDistribution[stars - 1];
        final percentage = ratingCount > 0 ? (count / ratingCount) * 100 : 0.0;

        return RatingBarItem(
          stars: stars,
          percentage: percentage,
          index: index,
          duration: duration,
          curve: curve,
        );
      }),
    );
  }
}
