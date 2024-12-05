import 'dart:ui';
import 'dart:math';
class HYSizeFit {
  static double? physicalWidth;
  static double? physicalHeight;
  static double? screenWidth;
  static double? screenHeight;
  static double? dpr;
  static double? statusHeight;

  static double? rpx;
  static double? px;

  static void initialize({double standardSize = 1280}) {
    // Get the physical dimensions of the screen
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;
    dpr = window.devicePixelRatio;

    // Logical dimensions of the screen
    screenWidth = physicalWidth! / dpr!;
    screenHeight = physicalHeight! / dpr!;

    // Status bar height
    statusHeight = window.padding.top / dpr!;

    // Calculate rpx and px based on the standard size
    rpx = screenWidth! / standardSize;
    px = rpx! * 2;
  }

  // Methods to convert sizes
  static double getRpx(double size) {
    return size * rpx!;
  }

  static double getPx(double size) {
    return size * px!;
  }
}

extension DoubleFit on double {
  double get px {
    return HYSizeFit.getPx(this);
  }

  double get rpx {
    return HYSizeFit.getRpx(this);
  }
}

extension IntFit on int {
  double get px {
    return HYSizeFit.getPx(this.toDouble());
  }

  double get rpx {
    return HYSizeFit.getRpx(this.toDouble());
  }
}

