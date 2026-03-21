import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

/// App-wide color palette, split into semantic categories.
class AppColors {
  // ========== Core Colors ==========
  static const Color primary = Color(0xffef233c);
  static const Color secondary = Color(0xff272b30);
  static const Color green = Color(0xff00ff00);
  static const Color error = Colors.red;
  static const Color authorSubjectCardBackground = Color.fromARGB(
    255,
    138,
    190,
    254,
  );
  static const Color black =
      Colors.black; // LinearGradient in Slider Card Image
  static const Color transparent =
      Colors.transparent; // LinearGradient in Slider Card Image

  // ========== Divider Colors ==========
  static const Color divider = Color(0xff303438);

  // ========== Text Field Colors ==========
  static const Color textFieldBackground = Color(0xff303438);
  static const Color textFieldHint = Color(0xffa9aaac);
  static const Color textFieldText = Colors.white;
  static const Color textFieldBorder = Color(0xffa9aaac);
  static const Color textFieldCursor = Colors.white;

  // ========== Background Colors ==========
  static const Color primaryBackground = Color(0xff1a1d1f);
  static const Color secondaryBackground = Color(0xff272b30);

  // ========== Bottom Navigation Bar Colors ========== // Fixed spelling: Buttm → Bottom
  static const Color selectedItemColor = activeIcon;
  static const Color unselectedItemColor = disabledIcon;

  // ========== Text Colors ==========
  static const Color primaryText = Color(0xffa9aaac);
  static const Color secondaryText = Colors.white;

  // ========== Icon Colors ==========
  static const Color defaultIcon =
      Colors.white; // Fixed spelling: defultIcon → defaultIcon
  static const Color activeIcon = primary;
  static const Color disabledIcon = Color(0xffa9aaac);
  static const Color ratingIcon = Color(0xffffbe21);
  static const Color primaryIconContainer = Color(
    0xB2272830,
  ); // Container behind icons
  static const Color secondaryIconContainer = Color(
    0xffef233c,
  ); // Container behind icons

  // ========== Dot Indicator Colors ==========
  static const Color activeDot = primary; // Use app primary color
  static const Color inactiveDot = Color(0x26ffffff);
  static const Color dotBackground = Color(
    0x33ffffff,
  ); // Detail Card Circle Dot

  // ========== Shimmer Colors ==========
  static const Color shimmerBase = Color(
    0xFF1A1A1A,
  ); // equivalent to Colors.grey[850]
  static const Color shimmerHighlight = Color(
    0xFF424242,
  ); // equivalent to Colors.grey[800]

  // ========== Rating Colors (Dynamic) ==========
  /// Returns a color based on star rating (1-5)
  static Color getRatingColor(int stars) {
    switch (stars) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow[700]!;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static Color getIconColor(String title) {
    switch (title) {
      case AppStrings.wantToRead:
        return Colors.blue;
      case AppStrings.currentlyReading:
        return Colors.orange;
      case AppStrings.alreadyRead:
        return Colors.green;
      case AppStrings.totalLogs:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}
