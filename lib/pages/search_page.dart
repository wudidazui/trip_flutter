import 'package:flutter/material.dart';
import 'package:trip_flutter/model/search_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/search_item_widget.dart';

import '../dao/search_dao.dart';
import '../widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String? keyword;
  final String? hint;
  const SearchPage({super.key, this.keyword, this.hint, this.hideLeft = false});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;
  String? keyword;

  get _appBar {
    double top = MediaQuery.of(context).padding.top;
    return shadowWarp(
        child: Container(
          height: 55 + top,
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.only(top: top),
          child: SearchBarWidget(
            hideLeft: widget.hideLeft,
            defaultText: widget.keyword,
            hint: widget.hint,
            leftButtonClick: () => NavigatorUtil.pop(context),
            onChanged: _onTextChange,
            rightButtonClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
        padding: EdgeInsets.only(bottom: 5));
  }

  get _listView => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Expanded(
          child: ListView.builder(
            itemCount: searchModel?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _item(index);
            },
          ),
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.keyword != null) {
      _onTextChange(widget.keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar,
          _listView,
        ],
      ),
    );
  }

  void _onTextChange(String? value) async {
    try {
      var result = await SearchDao.fetch(value ?? "");
      if (result == null) return;
      if (result.keyword == value) {
        setState(() {
          searchModel = result;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _item(int index) {
    var item = searchModel?.data?[index];
    if (item == null) return Container();
    return SearchItemWidget(
      searchItem: item,
      searchModel: searchModel,
    );
  }
}
