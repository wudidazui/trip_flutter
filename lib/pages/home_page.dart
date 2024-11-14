import 'package:flutter/material.dart';
import 'package:trip_flutter/widget/loading_container.dart';
import 'package:trip_flutter/widget/sales_box_widget.dart';

import '../dao/home_dao.dart';
import '../model/home_model.dart';
import '../widget/banner_widget.dart';
import '../widget/grid_nav_widget.dart';
import '../widget/sub_nav_widget.dart';
import 'local_nav_widget.dart';

class HomePage extends StatefulWidget {
  static Config? configModel;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  static const appbarScrollOffset = 100;

  double appBarAlpha = 0;
  bool _loading = true;

  List<BannerItem> bannerList = [];
  List<LocalNavItem> localNavList = [];
  List<SubNavItem> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;

  get _appBar => Opacity(
        opacity: appBarAlpha,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          height: 80,
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("首页"),
            ),
          ),
        ),
      );

  get _listView => ListView(
        children: [
          BannerWidget(
            bannerList: bannerList,
          ),
          LocalNavWidget(
            localNavList: localNavList,
          ),
          if (gridNavModel != null) GridNavWidget(gridNavModel: gridNavModel),
          SubNavWidget(subNavList: subNavList),
          if (salesBoxModel != null) SalesBoxWidget(salesBox: salesBoxModel!)
        ],
      );

  get _contentView => MediaQuery.removePadding(
      removeTop: true, //移除顶部留白
      context: context,
      child: RefreshIndicator(
        color: Colors.blue,
        onRefresh: _handleRefresh,
        child: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              _onScroll(scrollNotification.metrics.pixels);
            }
            return false;
          },
          child: _listView,
        ),
      ));

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      //loading
      body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: [_contentView, _appBar],
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _onScroll(double offset) {
    double alpha = offset / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel? model = await HomeDao.fetch();
      // if (model == null) {
      //   setState(() {
      //     _loading = false;
      //   });
      //   return;
      // }
      setState(() {
        HomePage.configModel = model.config;
        localNavList = model.localNavList ?? [];
        subNavList = model.subNavList ?? [];
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList ?? [];
        _loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }
}
