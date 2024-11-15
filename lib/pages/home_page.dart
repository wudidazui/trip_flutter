import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/pages/search_page.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/loading_container.dart';
import 'package:trip_flutter/widget/sales_box_widget.dart';
import 'package:trip_flutter/widget/search_bar_widget.dart';

import '../dao/home_dao.dart';
import '../model/home_model.dart';
import '../widget/banner_widget.dart';
import '../widget/grid_nav_widget.dart';
import '../widget/sub_nav_widget.dart';
import 'local_nav_widget.dart';

const searchBarDefaultText = "网红打卡地 景点 酒店 美食";

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

  get _appBar {
    //获取刘海屏实际的Top 安全编剧
    double top = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        shadowWarp(
            child: Container(
          padding: EdgeInsets.only(top: top),
          height: 60 + top,
          decoration: BoxDecoration(
              color:
                  Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
          child: SearchBarWidget(
            searchBarType: appBarAlpha > 0.2
                ? SearchBarType.homeLight
                : SearchBarType.home,
            inputBoxClick: _jumpToSearch,
            defaultText: searchBarDefaultText,
            rightButtonClick: () {
              LoginDao.logOut();
            },
          ),
        )),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

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

  void _jumpToSearch() {
    NavigatorUtil.push(context, SearchPage());
  }
}
