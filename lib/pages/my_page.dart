import 'package:flutter/material.dart';
import 'package:trip_flutter/widget/hi_webview.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: HiWebView(
      url:
          'https://m.ctrip.com/webapp/myctrip/?from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F1',
      hideAppBar: true,
      backForbid: true,
      statusBarColor: "017ac",
      // backForbid: true,
      // statusBarColor: '0176ac',
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
