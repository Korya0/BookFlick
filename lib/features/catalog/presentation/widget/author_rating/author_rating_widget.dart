import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/animations/slide_in_animation.dart';
import 'package:bookna_app/features/catalog/domain/entities/author.dart';
import 'package:bookna_app/features/catalog/presentation/widget/author_rating/rating_header.dart';
import 'package:bookna_app/features/catalog/presentation/widget/author_rating/rating_bars.dart';
import 'package:flutter/material.dart';

class AuthorRatingWidget extends StatelessWidget {
  final Author author;
  final Duration animationDuration;
  final Curve animationCurve;

  const AuthorRatingWidget({
    super.key,
    required this.author,
    this.animationDuration = const Duration(milliseconds: AppConstants.longAnimationDuration),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  Widget build(BuildContext context) {
    final ratingCount = author.ratingsCount?.toInt() ?? 0;
    final ratingAverage = author.ratingsAverage?.toDouble();
    final ratingDistribution = _getRatingDistribution();

    return SlideInAnimation(
      delay: 0,
      duration: animationDuration,
      curve: animationCurve,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.ratings,
            style: TextStyle(fontSize: AppSize.s20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSize.s8),
          RatingHeader(
            ratingAverage: ratingAverage,
            ratingCount: ratingCount,
            animationDuration: animationDuration,
          ),
          const SizedBox(height: AppSize.s8),
          RatingBars(
            ratingCount: ratingCount,
            ratingDistribution: ratingDistribution,
            duration: animationDuration,
            curve: animationCurve,
          ),
        ],
      ),
    );
  }

  List<int> _getRatingDistribution() => [
        author.ratingsCount1?.toInt() ?? 0,
        author.ratingsCount2?.toInt() ?? 0,
        author.ratingsCount3?.toInt() ?? 0,
        author.ratingsCount4?.toInt() ?? 0,
        author.ratingsCount5?.toInt() ?? 0,
      ];
}
