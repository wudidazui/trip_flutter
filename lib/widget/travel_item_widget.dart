import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:trip_flutter/model/travel_model.dart';

class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  final int? index;
  const TravelItemWidget({super.key, required this.item, this.index});

  get _title => Container(
        padding: EdgeInsets.all(4),
        child: Text(
          item.article?.articleTitle ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      );

  get _infoText => Container(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_avatarNickName, _lickIcon],
        ),
      );

  get _avatarNickName => Row(
        children: [
          PhysicalModel(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              item?.article?.author?.coverImage?.dynamicUrl ?? "",
              width: 24,
              height: 24,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: 90,
            child: Text(
              item.article?.author?.nickName ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      );

  get _lickIcon => Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(
              Icons.thumb_up,
              size: 14,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Text(
              item.article?.likeCount.toString() ?? "",
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      );

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: size.width / 2 - 10,
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item?.article?.images?[0].dynamicUrl ?? "",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            left: 8,
            bottom: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(
                        _poiName(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo h5
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_itemImage(context), _title, _infoText],
          ),
        ),
      ),
    );
  }

  String _poiName() {
    return item.article?.pois == null || item.article!.pois!.isEmpty
        ? "未知"
        : item.article!.pois?[0].poiName ?? "";
  }
}
