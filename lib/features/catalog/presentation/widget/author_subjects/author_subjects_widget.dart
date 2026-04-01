import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/animations/fade_in_animation.dart';
import 'package:bookna_app/core/presentation/widget/animations/slide_in_animation.dart';
import 'package:bookna_app/features/catalog/domain/entities/author.dart';
import 'package:bookna_app/features/catalog/presentation/widget/author_subjects/subject_chip.dart';
import 'package:flutter/material.dart';

class AuthorSubjectsWidget extends StatelessWidget {
  final Author author;
  final int? maxSubjectsToShow;
  final Duration animationDuration;
  final Curve animationCurve;

  const AuthorSubjectsWidget({
    super.key,
    required this.author,
    this.maxSubjectsToShow,
    this.animationDuration = const Duration(
      milliseconds: AppConstants.midAnimationDuration,
    ),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = author.topSubjects ?? [];
    final displayed = _getDisplayedSubjects(subjects);

    return SlideInAnimation(
      delay: 0,
      duration: animationDuration,
      curve: animationCurve,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppSize.s12),
          if (subjects.isNotEmpty)
            _buildChipsWrap(displayed)
          else
            _buildNoSubjects(),
          if (subjects.length > (maxSubjectsToShow ?? 0) &&
              maxSubjectsToShow != null)
            _buildMoreIndicator(subjects.length, displayed.length),
        ],
      ),
    );
  }

  Widget _buildHeader() => const Text(
    AppStrings.topSubjects,
    style: TextStyle(fontSize: AppSize.s20, fontWeight: FontWeight.bold),
  );

  Widget _buildChipsWrap(List<String> displayed) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children:
        displayed.asMap().entries.map((entry) {
          return SubjectChip(
            subject: entry.value,
            index: entry.key,
            duration: animationDuration,
          );
        }).toList(),
  );

  Widget _buildNoSubjects() => FadeInAnimation(
    delay: 200,
    duration: animationDuration,
    child: Text(
      AppStrings.noSubjectsAvailable,
      style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
    ),
  );

  Widget _buildMoreIndicator(int total, int showing) => FadeInAnimation(
    delay: 300 + (showing * 100),
    duration: animationDuration,
    child: Padding(
      padding: const EdgeInsets.only(top: AppPadding.p8),
      child: Text(
        '+ ${total - showing} more',
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
    ),
  );

  List<String> _getDisplayedSubjects(List<String> subjects) =>
      maxSubjectsToShow != null && maxSubjectsToShow! > 0
          ? subjects.take(maxSubjectsToShow!).toList()
          : subjects;
}
