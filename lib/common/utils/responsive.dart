import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'size.dart';

class ResponsiveUtils {
  final BuildContext context;

  const ResponsiveUtils(
    this.context,
  );

  // Media Size
  Size _getMediaQuerySize() => MediaQuery.of(context).size;

  /// Media Size Height
  double getMediaQueryHeight() => _getMediaQuerySize().height;

  /// Media Size Width
  double getMediaQueryWidth() => _getMediaQuerySize().width;

  /// Check keyboard is show or hide
  bool isKeyboardShown() => MediaQuery.of(context).viewInsets.bottom > 0;

  /// Small Mobile Device width <= 375
  bool isSmallMobileSize() => getMediaQueryWidth() <= 375;

  /// Mobile Device width > 375 && width <= 480
  bool isNormalMobileSize() =>
      getMediaQueryWidth() > 375 && getMediaQueryWidth() <= 480;

  /// Tablet Device width > 480 && width <= 768
  bool isTabletSize() =>
      getMediaQueryWidth() > 480 && getMediaQueryWidth() <= 768;

  /// Desktop Device width > 768
  bool isDesktopSize() => getMediaQueryWidth() > 768;

  /// Responsive Font Size
  double getResponsiveFontSize(
    double normal, {
    double? small,
    double? tablet,
    double? desktop,
  }) {
    if (isSmallMobileSize()) {
      return normal - 1;
    }
    if (isNormalMobileSize()) {
      return normal;
    }
    if (isTabletSize()) {
      return tablet ?? normal + 1;
    }
    if (isDesktopSize()) {
      return desktop ?? tablet ?? normal + 1;
    }
    return 0;
  }

  /// Bottom & Top View Padding
  EdgeInsets getMediaQueryPadding() => MediaQuery.of(context).viewPadding;

  /// Bottom View Padding
  double getMediaQueryPaddingBottom() => getMediaQueryPadding().bottom;

  /// Top View Padding
  double getMediaQueryPaddingTop() => getMediaQueryPadding().top;

  /// Check is have Bottom View Padding
  bool isHavePaddingBottom() => getMediaQueryPaddingBottom() != 0;

  /// Check is have Top View Padding
  bool isHavePaddingTop() => getMediaQueryPaddingBottom() != 0;

  /// Responsive Bottom Padding
  double getResponsiveBottomPadding() {
    if (!kIsWeb && Platform.isIOS) {
      return AppGap.big;
    } else {
      return getMediaQueryPaddingBottom() +
          (isHavePaddingBottom() ? AppGap.medium : AppGap.large);
    }
  }

  /// Responsive Top Padding
  double getResponsivePaddingTop() {
    return getMediaQueryPaddingTop() +
        kToolbarHeight +
        (isHavePaddingTop() ? AppGap.medium : AppGap.large);
  }

  /// Set Responsive Padding
  double getResponsivePadding(
    double normal, {
    double? small,
    double? tablet,
    double? desktop,
  }) {
    if (isSmallMobileSize()) {
      return small ?? normal;
    }
    if (isNormalMobileSize()) {
      return normal;
    }
    if (isTabletSize()) {
      return tablet ?? normal;
    }
    if (isDesktopSize()) {
      return desktop ?? tablet ?? normal;
    }
    return 0;
  }

  /// Set Responsive Icon Size
  double getResponsiveIconSize(
    double normal, {
    double? small,
    double? tablet,
    double? desktop,
  }) {
    if (isSmallMobileSize()) {
      return small ?? normal;
    }
    if (isNormalMobileSize()) {
      return normal;
    }
    if (isTabletSize()) {
      return tablet ?? normal;
    }
    if (isDesktopSize()) {
      return desktop ?? tablet ?? normal;
    }
    return 0;
  }

  /// Set Responsive Logo Size
  double getResponsiveLogoSize(
    double normal, {
    double? small,
    double? tablet,
    double? desktop,
  }) {
    if (isSmallMobileSize()) {
      return small ?? normal;
    }
    if (isNormalMobileSize()) {
      return normal;
    }
    if (isTabletSize()) {
      return tablet ?? normal;
    }
    if (isDesktopSize()) {
      return desktop ?? tablet ?? normal;
    }
    return 0;
  }

  /// Set Responsive Positioned
  double getResponsivePosition(
    double normal, {
    double? small,
    double? tablet,
    double? desktop,
  }) {
    if (isSmallMobileSize()) {
      return small ?? normal;
    }
    if (isNormalMobileSize()) {
      return normal;
    }
    if (isTabletSize()) {
      return tablet ?? normal;
    }
    if (isDesktopSize()) {
      return desktop ?? tablet ?? normal;
    }
    return 0;
  }

  /// Set Responsive Size (it can be set for width/height of the widgets)
  double getResponsiveSize(
    double normal, {
    double? small,
    double? tablet,
    double? desktop,
  }) {
    if (isSmallMobileSize()) {
      return small ?? normal;
    }
    if (isNormalMobileSize()) {
      return normal;
    }
    if (isTabletSize()) {
      return tablet ?? normal;
    }
    if (isDesktopSize()) {
      return desktop ?? tablet ?? normal;
    }
    return 0;
  }
}
