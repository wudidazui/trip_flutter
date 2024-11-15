import 'package:flutter/material.dart';
import 'package:trip_flutter/model/search_model.dart';

const types = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

class SearchItemWidget extends StatelessWidget {
  final SearchModel? searchModel;
  final SearchItem searchItem;
  const SearchItemWidget(
      {super.key, required this.searchItem, required this.searchModel});

  get _item => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.2, color: Colors.grey))),
        child: Row(
          children: [
            _iconContainer,
            Column(
              children: [
                SizedBox(
                  width: 300,
                  child: _title,
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child: _subTitle,
                )
              ],
            )
          ],
        ),
      );

  get _title {
    //设置富文本
    List<TextSpan> spans = [];
    spans
        .addAll(_keywordTextSpans(searchItem.word, searchModel?.keyword ?? ''));
    spans.add(TextSpan(
        text: ' ${searchItem.districtname ?? ''} ${searchItem.zonename ?? ''}',
        style: const TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  get _subTitle => Row(
        children: [
          Text(searchItem.price ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.orange,
              )),
          Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(searchItem.star ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  )))
        ],
      );

  get _iconContainer => Container(
        margin: EdgeInsets.all(1),
        child: Image(
          height: 26,
          width: 26,
          image: AssetImage(_typeImage(searchItem.type)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    print('wordwoc'.split('w'));
    return GestureDetector(
      onTap: () {
        //todo h5
      },
      child: _item,
    );
  }

  String _typeImage(String? type) {
    if (type == null) {
      return 'images/type_travelgroup.png';
    }
    String path = 'travelgroup';
    for (final val in types) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  List<TextSpan> _keywordTextSpans(String? word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.isEmpty) return spans;
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    List<String> arr = wordL.split(keywordL);
    //'wordwoc'.split('w') -> [, ord, oc]
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        //搜索关键字高亮忽略大小写
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle));
      }
      String val = arr[i];
      if (val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
