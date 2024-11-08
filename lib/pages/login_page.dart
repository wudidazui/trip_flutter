import 'package:flutter/material.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/screen_adapter_helper.dart';
import 'package:trip_flutter/widget/input_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dao/login_dao.dart';
import '../util/string_util.dart';
import '../util/view_util.dart';
import '../widget/login_widget.dart';

//登录页
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  String? userName;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [..._background(), ..._content(context)],
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

  _content(BuildContext context) {
    return [
      Positioned.fill(
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
                  userName = text;
                  _checkInput();
                },
              ),
              hiSpace(height: 10.px),
              InputWidget(
                hint: "请输入密码",
                obscureText: true,
                onChanged: (text) {
                  password = text;
                  _checkInput();
                },
              ),
              hiSpace(height: 45.px),
              LoginButton(
                title: "登录",
                enable: loginEnable,
                onPressed: () => _login(context),
              ),
              hiSpace(height: 15.px),
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => _jumpRegistration(),
                    child: Text(
                      "注册账号",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ))
    ];
  }

  void _checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _login(BuildContext context) {
    try {
      var result = LoginDao.login(userName: userName!, password: password!);
      NavigatorUtil.goToHome(context);
      print("登录成功");
    } catch (e) {
      print(e);
    }
  }

  _jumpRegistration() async {
    Uri uri = Uri.parse("https://xiaoda.damao.pro/");
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw "Could not launch $uri";
    }
  }
}
