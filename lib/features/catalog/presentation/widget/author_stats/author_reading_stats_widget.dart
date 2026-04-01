import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/animations/fade_in_animation.dart';
import 'package:bookna_app/core/presentation/widget/animations/slide_in_animation.dart';
import 'package:bookna_app/features/catalog/domain/entities/author.dart';
import 'package:bookna_app/features/catalog/presentation/widget/author_stats/stat_card.dart';
import 'package:bookna_app/features/catalog/presentation/widget/author_stats/stat_item_model.dart';
import 'package:flutter/material.dart';

class AuthorReadingStatsWidget extends StatelessWidget {
  final Author author;
  final Duration animationDuration;
  final Curve animationCurve;

  const AuthorReadingStatsWidget({
    super.key,
    required this.author,
    this.animationDuration = const Duration(
      milliseconds: AppConstants.midAnimationDuration,
    ),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  Widget build(BuildContext context) {
    final stats = _getStats();
    final hasStats = stats.any((stat) => stat.value > 0);

    return SlideInAnimation(
      delay: 0,
      duration: animationDuration,
      curve: animationCurve,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.readingStats,
            style: TextStyle(
              fontSize: AppSize.s20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSize.s16),
          if (hasStats) _buildStatsGrid(stats) else _buildNoStats(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(List<StatItem> stats) => Wrap(
    spacing: 16,
    runSpacing: 16,
    children:
        stats
            .where((stat) => stat.value > 0)
            .map(
              (stat) => StatCard(
                stat: stat,
                index: stats.indexOf(stat),
                duration: animationDuration,
                curve: animationCurve,
              ),
            )
            .toList(),
  );

  Widget _buildNoStats() => FadeInAnimation(
    delay: 200,
    duration: animationDuration,
    child: Text(
      AppStrings.noReadingStatsAvailable,
      style: TextStyle(color: Colors.grey[600]),
    ),
  );

  List<StatItem> _getStats() => [
    StatItem(
      title: AppStrings.wantToRead,
      value: (author.wantToReadCount ?? 0).toInt(),
      icon: Icons.bookmark,
    ),
    StatItem(
      title: AppStrings.currentlyReading,
      value: (author.currentlyReadingCount ?? 0).toInt(),
      icon: Icons.menu_book,
    ),
    StatItem(
      title: AppStrings.alreadyRead,
      value: (author.alreadyReadCount ?? 0).toInt(),
      icon: Icons.check_circle,
    ),
    StatItem(
      title: AppStrings.totalLogs,
      value: (author.readingLogCount ?? 0).toInt(),
      icon: Icons.library_books,
    ),
  ];
}
