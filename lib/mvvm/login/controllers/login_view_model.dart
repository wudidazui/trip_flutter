import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../dao/login_dao.dart';
import '../../../util/navigator_util.dart';

enum LoginInputType { username, password }

class LoginViewModel extends GetxController {
  final loginEnable = false.obs;
  String? userName;
  String? password;

  void onValueChanged(String value, LoginInputType type) {
    if (type == LoginInputType.username) {
      userName = value;
    } else {
      password = value;
    }
    loginEnable(userName != null &&
        userName!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty);
  }

  login() {
    try {
      var result = LoginDao.login(userName: userName!, password: password!);
      NavigatorUtil.goToHome();
      print("登录成功");
    } catch (e) {
      print(e);
    }
  }

  jumpRegistration() async {
    Uri uri = Uri.parse("https://xiaoda.damao.pro/");
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw "Could not launch $uri";
    }
  }
}
