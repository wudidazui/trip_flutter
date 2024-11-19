import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/login/controllers/login_view_model.dart';
import 'package:trip_flutter/util/screen_adapter_helper.dart';
import 'package:trip_flutter/widget/input_widget.dart';

import '../../../util/view_util.dart';
import '../../../widget/login_widget.dart';

//登录页
class LoginPage extends GetView<LoginViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [..._background(), Obx(() => _content())],
      ),
    );
  }

  _background() {
    return [
      Positioned.fill(
          child: Image.asset(
        "images/login-bg1.jpg",
        fit: BoxFit.cover,
      )),
      Positioned.fill(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black54),
        ),
      )
    ];
  }

  _content() {
    return Positioned.fill(
        left: 25.px,
        right: 25.px,
        child: ListView(
          children: [
            hiSpace(height: 100.px),
            Text(
              "账号密码登录",
              style: TextStyle(fontSize: 26.px, color: Colors.white),
            ),
            hiSpace(height: 40.px),
            InputWidget(
              hint: "请输入账号",
              onChanged: (text) {
                controller.onValueChanged(text, LoginInputType.username);
              },
            ),
            hiSpace(height: 10.px),
            InputWidget(
              hint: "请输入密码",
              obscureText: true,
              onChanged: (text) {
                controller.onValueChanged(text, LoginInputType.password);
              },
            ),
            hiSpace(height: 45.px),
            LoginButton(
              title: "登录",
              enable: controller.loginEnable.value,
              onPressed: () => controller.login(),
            ),
            hiSpace(height: 15.px),
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => controller.jumpRegistration(),
                  child: Text(
                    "注册账号",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ));
  }
}
