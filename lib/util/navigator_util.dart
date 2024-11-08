import 'package:flutter/material.dart';

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

  //跳转到登录页
  static goToLogin() {
    //不让返回
    Navigator.pushReplacement(
        _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
