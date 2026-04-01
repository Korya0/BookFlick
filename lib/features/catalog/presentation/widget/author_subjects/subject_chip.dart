import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/animations/bounce_in_animation.dart';
import 'package:flutter/material.dart';

class SubjectChip extends StatelessWidget {
  final String subject;
  final int index;
  final Duration duration;

  const SubjectChip({
    super.key,
    required this.subject,
    required this.index,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return BounceInAnimation(
      delay: 300 + (index * 100),
      duration: duration,
      child: Chip(
        label: Text(subject, style: const TextStyle(fontSize: 14)),
        backgroundColor: AppColors.authorSubjectCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
      ),
    );
  }
}
