import 'dart:convert';

import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:http/http.dart' as http;
import 'package:trip_flutter/util/navigator_util.dart';

class LoginDao {
  static const token = "";
  static login({required String userName, required String password}) async {
    Map<String, String> paramsMap = {};
    paramsMap["username"] = userName;
    paramsMap["password"] = password;
    var uri = Uri.http("192.168.110.11:8085", "/member/login", paramsMap);
    final response = await http.post(uri);
    Utf8Decoder utf8decoder = Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    print(bodyString);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      if (result['code'] == 200 && result['data'] != null) {
        //保存登录令牌
        var map = result['data'];
        _saveToken(map['token']);
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception("请求失败");
    }
  }

  static void _saveToken(String token) {
    HiCache.getInstance().setString("token", token);
  }

  static getToken() {
    return HiCache.getInstance().get("token");
  }

  static void logOut() {
    HiCache.getInstance().remove("token");
    NavigatorUtil.goToLogin();
  }
}
