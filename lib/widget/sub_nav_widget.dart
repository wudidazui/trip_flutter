import 'package:flutter/material.dart';

import '../model/home_model.dart';

class SubNavWidget extends StatelessWidget {
  List<SubNavItem>? subNavList;
  SubNavWidget({super.key, this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 4, 7, 4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) {
      return null;
    }
    List<Widget> items = [];
    for (var model in subNavList!) {
      items.add(_item(context, model));
    }
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList!.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, SubNavItem model) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        //todo
      },
      child: Column(
        children: [
          Image.network(
            model.icon!,
            width: 18,
            height: 18,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              model.title!,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    ));
  }
}
