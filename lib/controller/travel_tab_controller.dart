import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/model/travel_model.dart';

import '../dao/travel_dao.dart';

class TravelTabController extends GetxController {
  late final String? groupChannelCode;
  TravelTabController(this.groupChannelCode);

  final travelItems = <TravelItem>[].obs;
  final loading = true.obs;
  int pageIndex = 1;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadData(loadMore: true);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  Future<void> loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelItemModel model =
          await TravelDao.getTravels(groupChannelCode, pageIndex, 10);
      List<TravelItem> items = _filterItems(model.resultList);
      if (items.isEmpty) {
        pageIndex--;
      }
      loading.value = false;
      if (!loadMore) {
        travelItems.clear();
      }
      travelItems.addAll(items);
    } catch (e) {
      debugPrint(e.toString());
      loading.value = false;
      if (loadMore) {
        pageIndex--;
      }
    }
  }

  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if (resultList == null) return [];
    List<TravelItem> filterItems = [];
    for (var item in resultList) {
      if (item.article != null) {
        filterItems.add(item);
      }
      ;
    }
    return filterItems;
  }
}
