import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/routes/app_pages.dart';

import '../widget/hi_webview.dart';

class NavigatorUtil {
  // static BuildContext? _context;
  // static updateContext(BuildContext context) {
  //   NavigatorUtil._context = context;
  // }

  //跳转到指定页面
  static push(BuildContext context, Widget page) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    Get.to(page);
  }

  //跳转到首页
  static goToHome() {
    //不让返回
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const TabNavigator()));
    // Get.offAll(TabNavigator());
    Get.offAllNamed(Routes.MAIN);
  }

  ///返回上一页
  static pop(BuildContext context) {
    // if (Navigator.canPop(context)) {
    //   Navigator.pop(context);
    // } else {
    //   //退出APP
    //   SystemNavigator.pop();
    // }
    Get.back();
  }

  //跳转到登录页
  static goToLogin() {
    //不让返回
    // Navigator.pushReplacement(
    //     _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
    Get.offAllNamed(Routes.LOGIN);
  }

  static jumpH5(
      {BuildContext? context,
      String? url,
      String? title,
      bool? hideAppBar,
      String? statusBarColor}) {
    BuildContext? safeContext;
    if (url == null) {
      debugPrint('url is null jumpH5 failed.');
      return;
    }
    // if (context != null) {
    //   safeContext = context;
    // } else if (_context?.mounted ?? false) {
    //   safeContext = _context;
    // } else {
    //   debugPrint('context is null jumpH5 failed.');
    //   return;
    // }

    // Navigator.push(
    //     safeContext!,
    //     MaterialPageRoute(
    //         builder: (context) => HiWebView(
    //               url: url,
    //               title: title,
    //               hideAppBar: hideAppBar,
    //               statusBarColor: statusBarColor,
    //             )));
    Get.to(HiWebView(
      url: url,
      title: title,
      hideAppBar: hideAppBar,
      statusBarColor: statusBarColor,
    ));
  }
}
