import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /*
  // --- Theme & Colors ---
  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>()!;

  TextTheme get textStyles => Theme.of(this).textTheme;

  AppTextThemeExtension get customTextStyles =>
      Theme.of(this).extension<AppTextThemeExtension>()!;

  // --- Localization ---
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  // --- Screen Dimensions (Media Query Helpers) ---
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;
*/
  // --- Keyboard & Focus ---
  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.unfocus();
    }
  }

  /*
  // --- Platform Detection ---
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isWeb => kIsWeb;
  */
}
