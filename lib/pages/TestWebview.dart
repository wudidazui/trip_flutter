import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 1
  late WebViewController controller;
  @override
  void initState() {
    // 2
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://juejin.cn'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
              children: [
                // 3
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft, // 渐变的开始位置
                      end: Alignment.bottomRight, // 渐变的结束位置
                      colors: [Colors.blue, Colors.green], // 渐变的颜色
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('渐变背景！', style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
            floatingActionButton: ElevatedButton(
              onPressed: () async {
                var height = await controller.runJavaScriptReturningResult(
                    'document.scrollingElement.scrollHeight') as int;
                var scrollTo = height;
                controller.scrollTo(0, scrollTo);
              },
              child: Text('滚动一半内容'),
            )));
  }
}
