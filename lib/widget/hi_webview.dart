import 'package:flutter/material.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiWebView extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid;

  const HiWebView(
      {super.key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid});

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {
  String? url;
  late WebViewController controller;

  final _catchUrls = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5'
  ];

  @override
  void initState() {
    super.initState();
    url = widget.url;
    if (url != null && url!.contains('ctrip.com')) {
      url = url!.replaceAll("http://", "https://");
    }
    _initWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    //处理Android物理返回键，返回H5的上一页 https://docs.flutter.dev/release/breaking-changes/android-predictive-back
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (await controller.canGoBack()) {
            controller.goBack();
          } else {
            if (context.mounted) NavigatorUtil.pop(context);
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              _appBar(
                  Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
              Expanded(
                  child: WebViewWidget(
                controller: controller,
              ))
            ],
          ),
        ));
  }

  void _initWebViewController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('progress:$progress');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            _handleBackForbid();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (_isToMain(request.url)) {
              debugPrint("阻止跳转到 $request");
              NavigatorUtil.pop(context);
              return NavigationDecision.prevent;
            } else {
              debugPrint("允许跳转到 $request");
              return NavigationDecision.navigate;
            }
          }))
      ..loadRequest(Uri.parse(url!));
  }

  void _handleBackForbid() {}

  bool _isToMain(String url) {
    bool contain = false;
    for (final vale in _catchUrls) {
      if (url?.endsWith(vale) ?? false) {
        contain = true;
        break;
      }
    }

    return contain;
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    double top = MediaQuery.of(context).padding.top;
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: top,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, top, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [_backButton(backButtonColor), _title(backButtonColor)],
        ),
      ),
    );
  }

  _backButton(Color backButtonColor) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Icon(
          Icons.close,
          color: backButtonColor,
          size: 26,
        ),
      ),
    );
  }

  _title(Color backButtonColor) {
    return Positioned(
        left: 0,
        right: 0,
        child: Center(
          child: Text(
            widget.title ?? "",
            style: TextStyle(color: backButtonColor, fontSize: 20),
          ),
        ));
  }
}
