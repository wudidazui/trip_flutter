import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trip_flutter/widget/loading_container.dart';

import '../dao/travel_dao.dart';
import '../model/travel_model.dart';
import '../widget/travel_item_widget.dart';

class TravelTabPage extends StatefulWidget {
  final String? groupChannelCode;
  const TravelTabPage({super.key, this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  get _gridView => MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      itemCount: travelItems.length,
      itemBuilder: (BuildContext context, int index) => TravelItemWidget(
            index: index,
            item: travelItems[index],
          ));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          color: Colors.blue,
          onRefresh: _loadData,
          child: MediaQuery.removePadding(
              context: context, removeTop: true, child: _gridView),
        ),
      ),
    );
  }

  Future<void> _loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelItemModel model =
          await TravelDao.getTravels(widget!.groupChannelCode, pageIndex, 10);
      List<TravelItem> items = _filterItems(model.resultList);
      if (items.isEmpty) {
        pageIndex--;
      }
      setState(() {
        _loading = false;
        if (loadMore) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _loading = false;
        if (loadMore) {
          pageIndex--;
        }
      });
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
