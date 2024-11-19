import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/controller/travel_tab_controller.dart';
import 'package:trip_flutter/widget/loading_container.dart';

import '../widget/travel_item_widget.dart';

class TravelTabPage extends StatefulWidget {
  final String? groupChannelCode;
  const TravelTabPage({super.key, this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  late TravelTabController controller;

  get getx => GetX<TravelTabController>(
        builder: (controller) {
          return Scaffold(
            body: LoadingContainer(
              isLoading: controller.loading.value,
              child: RefreshIndicator(
                color: Colors.blue,
                onRefresh: _handelRefresh,
                child: MediaQuery.removePadding(
                    context: context, removeTop: true, child: _gridView),
              ),
            ),
          );
        },
        init: controller,
      );

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(TravelTabController(widget.groupChannelCode),
        tag: widget.groupChannelCode);
    super.initState();
  }

  get _gridView => MasonryGridView.count(
      controller: controller.scrollController,
      crossAxisCount: 2,
      itemCount: controller.travelItems.value.length,
      itemBuilder: (BuildContext context, int index) => TravelItemWidget(
            index: index,
            item: controller.travelItems.value[index],
          ));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return getx;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<void> _handelRefresh() async {
    await controller.loadData();
    return;
  }
}
