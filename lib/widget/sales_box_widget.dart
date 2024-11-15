import 'package:flutter/material.dart';
import 'package:trip_flutter/model/home_model.dart';

class SalesBoxWidget extends StatelessWidget {
  final SalesBox salesBox;
  const SalesBoxWidget({super.key, required this.salesBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: BoxDecoration(color: Colors.white),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    items.addAll([
      _doubleItem(context, salesBox.bigCard1, salesBox.bigCard2, true, false),
      _doubleItem(
          context, salesBox.smallCard1, salesBox.smallCard2, false, false),
      _doubleItem(
          context, salesBox.smallCard3, salesBox.smallCard4, false, true)
    ]);
    return Column(
      children: [
        _titleItem(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(0, 1)),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(1, 2)),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(2, 3))
      ],
    );
  }

  Widget _doubleItem(BuildContext context, SubNavItem? leftCard,
      SubNavItem? rightCard, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCard, big, true, last),
        _item(context, rightCard, big, false, last)
      ],
    );
  }

  //底部卡片 left为左侧卡片，big是否为大卡片，last是否为最后一张卡片
  _item(
      BuildContext context, SubNavItem? model, bool big, bool left, bool last) {
    BorderSide borderSide =
        BorderSide(width: 0.8, color: Colors.grey.withOpacity(0.3));
    double width = MediaQuery.of(context).size.width / 2 - 10;
    return GestureDetector(
      onTap: () {
        //todo
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              right: left ? borderSide : BorderSide.none,
              bottom: last ? BorderSide.none : borderSide),
        ),
        child: Image.network(
          model!.icon!,
          fit: BoxFit.fill,
          width: width,
          height: big ? 136 : 80,
        ),
      ),
    );
  }

  _titleItem() {
    return Container(
      height: 44,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            salesBox.icon!,
            height: 15,
            fit: BoxFit.fill,
          ),
          _moreItem()
        ],
      ),
    );
  }

  _moreItem() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              colors: [Color(0xffff4e63), Color(0xffff6cc9)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: GestureDetector(
        onTap: () {
          //todo
        },
        child: Text(
          "获取更多福利 >",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
