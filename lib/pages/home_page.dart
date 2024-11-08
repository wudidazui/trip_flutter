import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';

import '../widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  static const appbarScrollOffset = 100;
  double appBarAlpha = 0;
  get _appBar => Opacity(
        opacity: appBarAlpha,
        child: Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("首页"),
            ),
          ),
        ),
      );

  get _logoutBtn => ElevatedButton(
      onPressed: () {
        LoginDao.logOut();
      },
      child: Text("登出"));

  final bannerList = [
    "https://dimg04.c-ctrip.com/images/1nk4m12000borln3326A6.png",
    "https://ak-d.tripcdn.com/images/0AS27120009kzjhtr7F58.png",
    "https://ak-d.tripcdn.com/images/0AS3r120009kzjkibC271.png",
    "https://ak-d.tripcdn.com/images/0AS0e120009kzjgbh44C9.png",
    "https://ak-d.tripcdn.com/images/0AS29120009kzjqbuD463.png",
  ];

  // body: Column(
  //   children: [
  //     BannerWidget(
  //       bannerList: bannerList,
  //     )
  //   ],
  // ),
  get _listView => ListView(
        children: [
          BannerWidget(
            bannerList: bannerList,
          ),
          _logoutBtn,
          SizedBox(
            height: 800,
            child: ListTile(
              title: Text("哈哈"),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
              removeTop: true, //移除顶部留白
              context: context,
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                  return false;
                },
                child: _listView,
              )),
          _appBar
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _onScroll(double offset) {
    print("$offset");
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
}
