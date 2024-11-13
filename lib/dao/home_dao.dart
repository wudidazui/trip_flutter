import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

const HOME_URL = 'https://cdn.lishaoy.net/ctrip/homeConfig.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    var url = Uri.parse(HOME_URL);
    final response = await http.get(url);
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    debugPrint(bodyString);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      return HomeModel.fromJson(result);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }
      throw Exception(bodyString);
    }
  }
}
