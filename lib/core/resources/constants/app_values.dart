import 'package:flutter/material.dart';

class AppPadding {
  static const double p4 = 4.0;
  static const double p6 = 6.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p10 = 10.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
}

class AppMargin {
  static const double m8 = 8.0;
  static const double m10 = 10.0;
}

// App Size for Height and Width
class AppSize {
  static const double sInfinity = double.infinity; // 5
  static const double s1 = 1.0;
  static const double s4 = 4.0;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s15 = 15.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s30 = 30.0;
  static const double s35 = 35.0;
  static const double s40 = 40.0;
  static const double s45 = 45.0;
  static const double s60 = 60.0;
  static const double s100 = 100.0;
  static const double s110 = 110.0;
  static const double s120 = 120.0;
  static const double s130 = 128.0;
  static const double s140 = 140.0;
  static const double s150 = 150.0;
  static const double s160 = 160.0;
  static const double s175 = 175.0;
  static const double s190 = 190.0;
  static const double s200 = 200.0;
  static const double s220 = 220.0;
  static const double s240 = 240.0;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}

// Icon Size // Usage
class AppIconSize {
  static const double s12 = 12.0; // 2
  static const double s18 = 18.0; // 6
  static const double s20 = 20.0; // 18
  static const double s24 = 24.0; // 2
  static const double s30 = 30.0; // 3
  static const double s80 = 80.0; // 2
}

// Borer Radius // Usage
class AppRadius {
  static const double r4 = 4.0; // 3
  static const double r6 = 6.0; // 2
  static const double r8 = 8.0; // 10
  static const double r10 = 10.0; // 1
  static const double r12 = 12.0; // 1
  static const double r20 = 20.0; // 1
  static const double r24 = 24.0; // 1
  static const double r25 = 25.0; // 1
  static const double r100 = 100.0; // 2
}
