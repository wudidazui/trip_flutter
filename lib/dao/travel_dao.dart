import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/travel_category_model.dart';
import '../model/travel_model.dart';
import '../util/navigator_util.dart';

class TravelDao {
  static Future<TravelCategoryModel> getCategory() async {
    var uri = Uri.parse(
        "https://m.ctrip.com/restapi/soa2/15612/json/getTripShootHomePage");
    final response = await http.get(uri);
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var model = json.decode(bodyString);
      print(model);
      return TravelCategoryModel.fromJson(model);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }
      throw Exception(bodyString);
    }
  }

  static Future<TravelItemModel> getTravels(
      String? groupChannelCode, int pageIndex, int pageSize) async {
    Map<String, String> paramsMap = {};
    paramsMap['pageIndex'] = pageIndex.toString();
    paramsMap['pageSize'] = pageSize.toString();
    paramsMap['groupChannelCode'] = groupChannelCode ?? "";
    var uri = Uri.parse(
      "https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5&pageIndex=$pageIndex&pageSize=$pageSize&groupChannelCode=$groupChannelCode",
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel');
    }
  }
}
