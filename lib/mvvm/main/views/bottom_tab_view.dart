import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/main/controllers/controller.dart';

import '../../../pages/home_page.dart';
import '../../../pages/my_page.dart';
import '../../../pages/search_page.dart';
import '../../../pages/travel_page.dart';

class BottomTabView extends GetView<MainViewModel> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  const BottomTabView({super.key});

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        label: title);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.controller,
            children: [
              HomePage(),
              SearchPage(
                hideLeft: true,
              ),
              TravelPage(),
              MyPage()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.onButtonNavTap,
            type: BottomNavigationBarType.fixed,
            fixedColor: _activeColor,
            items: [
              _bottomItem("首页", Icons.home, 0),
              _bottomItem("搜索", Icons.search, 1),
              _bottomItem("旅拍", Icons.camera_alt, 2),
              _bottomItem("我的", Icons.account_circle, 3)
            ],
          ),
        ));
  }
}
