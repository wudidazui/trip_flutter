import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_flutter/widget/hi_webview.dart';

import '../navigator/tab_navigator.dart';
import '../pages/login_page.dart';

class NavigatorUtil {
  static BuildContext? _context;
  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  //跳转到指定页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  //跳转到首页
  static goToHome(BuildContext context) {
    //不让返回
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const TabNavigator()));
  }

  ///返回上一页
  static pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      //退出APP
      SystemNavigator.pop();
    }
  }

  //跳转到登录页
  static goToLogin() {
    //不让返回
    Navigator.pushReplacement(
        _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
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
    if (context != null) {
      safeContext = context;
    } else if (_context?.mounted ?? false) {
      safeContext = _context;
    } else {
      debugPrint('context is null jumpH5 failed.');
      return;
    }

    Navigator.push(
        safeContext!,
        MaterialPageRoute(
            builder: (context) => HiWebView(
                  url: url,
                  title: title,
                  hideAppBar: hideAppBar,
                  statusBarColor: statusBarColor,
                )));
  }
}
