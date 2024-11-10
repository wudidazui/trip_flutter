import 'package:flutter/material.dart';

class RefreshPage extends StatefulWidget {
  const RefreshPage({super.key});

  @override
  State<RefreshPage> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  final ScrollController _controller = ScrollController();
  List<String> cityNames = [
    '1111',
    '2222',
    '3333',
    '4444',
    '5555',
    '6666',
    '7777',
    '8888',
    '9999',
    '1000',
    '8989'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'refresh',
        home: Scaffold(
            appBar: AppBar(
              title: Text('refresh'),
            ),
            body: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView(
                controller: _controller,
                children: _buildList(),
              ),
            )));
  }

  _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(color: Colors.redAccent),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
  }

  void _loadData() async {
    await Future.delayed(Duration(microseconds: 200));
    setState(() {
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }
}
