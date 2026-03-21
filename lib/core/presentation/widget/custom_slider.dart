import 'package:bookna_app/core/resources/app_values.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../resources/app_constants.dart';

class CustomSlider extends StatelessWidget {
  final Widget Function(BuildContext context, int itemIndex, int) itemBuilder;
  const CustomSlider({required this.itemBuilder, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: AppConstants.carouselSliderItemsCount,
      options: CarouselOptions(
        scrollPhysics: const BouncingScrollPhysics(),
        viewportFraction: 1,
        height: AppSize.getScreenHeight(context) * 0.5,
        autoPlay: true,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
