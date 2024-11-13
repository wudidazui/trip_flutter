import 'package:flutter/material.dart';
import 'package:trip_flutter/model/home_model.dart';

class GridNavWidget extends StatelessWidget {
  final GridNav? gridNavModel;
  const GridNavWidget({super.key, this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridNavItems(context),
        ),
      ),
    );
  }

  //三个导航条
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNavModel?.hotel, true));
    items.add(_gridNavItem(context, gridNavModel?.flight, false));
    items.add(_gridNavItem(context, gridNavModel?.travel, false));
    return items;
  }

  Widget _gridNavItem(BuildContext context, Hotel? gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem?.mainItem));
    items.add(_doubleItem(context, gridNavItem?.item1, gridNavItem?.item2));
    items.add(_doubleItem(context, gridNavItem?.item3, gridNavItem?.item4));

    List<Widget> expandItems = [];
    for (var item in items) {
      expandItems.add(Expanded(flex: 1, child: item));
    }
    Color startColor = Color(int.parse("0xff${gridNavItem?.startColor!}"));
    Color endColor = Color(int.parse("0xff${gridNavItem?.endColor!}"));

    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: expandItems,
      ),
    );
  }

  Widget _mainItem(BuildContext context, LocalNavList? model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.network(
              model!.icon!,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                model.title!,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ));
  }

  //手式包裹器
  Widget _wrapGesture(BuildContext context, Widget widget) {
    return GestureDetector(
      onTap: () {
        //todo
      },
      child: widget,
    );
  }

  Widget _doubleItem(BuildContext context, Item2? topItem, Item2? bottomItem) {
    return Column(
      children: [
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false))
      ],
    );
  }

  _item(BuildContext context, Item2? item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: borderSide, bottom: first ? borderSide : BorderSide.none)),
      child: _wrapGesture(
          context,
          Center(
            child: Text(
              item!.title!,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )),
    );
  }
}
