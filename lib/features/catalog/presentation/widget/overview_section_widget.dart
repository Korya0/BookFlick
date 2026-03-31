import 'package:flutter/material.dart';
import 'package:bookna_app/core/presentation/widget/over_view_section.dart';

class OverviewSectionWidget extends StatelessWidget {
  final String? overview;

  const OverviewSectionWidget({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: OverviewSection(overview: overview ?? ''));
  }
}
