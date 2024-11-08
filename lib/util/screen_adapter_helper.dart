//屏幕适配工具类
import 'package:flutter/cupertino.dart';

extension InFix on int {
  double get px {
    return ScreenHelper.getPx(toDouble());
  }
}

extension DoubleFix on double {
  double get px {
    return ScreenHelper.getPx(this);
  }
}

class ScreenHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double ratio;

  //baseWith 设计稿宽度
  static init(BuildContext context, {double baseWidth = 375}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    ratio = screenWidth / baseWidth;
  }

  static double getPx(double size) {
    return ScreenHelper.ratio * size;
  }
}
