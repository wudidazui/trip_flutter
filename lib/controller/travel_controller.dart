import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dao/travel_dao.dart';
import '../model/travel_category_model.dart';

class TravelController extends GetxController with GetTickerProviderStateMixin {
  List<TravelTab> tabs = [];
  // TravelCategoryModel? travelTabModel;
  late TabController controller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = TabController(length: 0, vsync: this);
    TravelDao.getCategory().then((TravelCategoryModel? model) {
      controller = TabController(
          length: model?.district?.groups?.length ?? 0, vsync: this);
      tabs = model?.district?.groups ?? [];
      //travelTabModel = model;
      update();
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller.dispose();
  }
}
