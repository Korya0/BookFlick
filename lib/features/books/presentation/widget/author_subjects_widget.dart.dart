// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorSubjectsWidget extends StatefulWidget {
  final Author author;
  final int? maxSubjectsToShow;
  final Duration animationDuration;
  final Curve animationCurve;

  const AuthorSubjectsWidget({
    super.key,
    required this.author,
    this.maxSubjectsToShow,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  _AuthorSubjectsWidgetState createState() => _AuthorSubjectsWidgetState();
}

class _AuthorSubjectsWidgetState extends State<AuthorSubjectsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjects = widget.author.topSubjects ?? [];
    final hasSubjects = subjects.isNotEmpty;
    final displayedSubjects =
        widget.maxSubjectsToShow != null && widget.maxSubjectsToShow! > 0
            ? subjects.take(widget.maxSubjectsToShow!).toList()
            : subjects;

    return SlideInAnimation(
      delay: 0,
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.topSubjects,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSize.s12),
          if (hasSubjects)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  displayedSubjects.asMap().entries.map((entry) {
                    final index = entry.key;
                    final subject = entry.value;
                    return _buildSubjectChip(subject, index);
                  }).toList(),
            )
          else
            FadeInAnimation(
              delay: 200,
              duration: widget.animationDuration,
              child: Text(
                AppStrings.noSubjectsAvailable,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          if (hasSubjects &&
              widget.maxSubjectsToShow != null &&
              subjects.length > widget.maxSubjectsToShow!)
            FadeInAnimation(
              delay: 300 + (displayedSubjects.length * 100),
              duration: widget.animationDuration,
              child: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p8),
                child: Text(
                  '+ ${subjects.length - widget.maxSubjectsToShow!} more',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubjectChip(String subject, int index) {
    return BounceInAnimation(
      delay: 300 + (index * 100),
      duration: widget.animationDuration,
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

// Animation Widgets
class SlideInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;
  final Curve curve;

  const SlideInAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: curve,
      ),
      child: child,
      builder:
          (_, value, child) => Transform.translate(offset: value, child: child),
    );
  }
}

class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;

  const FadeInAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.easeIn,
      ),
      builder: (_, value, child) => Opacity(opacity: value, child: child),
      child: child,
    );
  }
}

class BounceInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;

  const BounceInAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.elasticOut,
      ),
      builder: (_, value, child) => Transform.scale(scale: value, child: child),
      child: child,
    );
  }
}
