class HomeModel {
  Config? config;
  List<SearchPlaceHolderItem>? searchPlaceHolderList;
  List<BannerItem>? bannerList;
  List<LocalNavItem>? localNavList;
  GridNav? gridNav;
  List<SubNavItem>? subNavList;
  SalesBox? salesBox;

  HomeModel(
      {this.config,
      this.searchPlaceHolderList,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  HomeModel.fromJson(Map<String, dynamic> json) {
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
    if (json['searchPlaceHolderList'] != null) {
      searchPlaceHolderList = <SearchPlaceHolderItem>[];
      json['searchPlaceHolderList'].forEach((v) {
        searchPlaceHolderList?.add(new SearchPlaceHolderItem.fromJson(v));
      });
    }
    if (json['bannerList'] != null) {
      bannerList = <BannerItem>[];
      json['bannerList'].forEach((v) {
        bannerList?.add(new BannerItem.fromJson(v));
      });
    }
    if (json['localNavList'] != null) {
      localNavList = <LocalNavItem>[];
      json['localNavList'].forEach((v) {
        localNavList?.add(new LocalNavItem.fromJson(v));
      });
    }
    gridNav =
        json['gridNav'] != null ? new GridNav.fromJson(json['gridNav']) : null;
    if (json['subNavList'] != null) {
      subNavList = <SubNavItem>[];
      json['subNavList'].forEach((v) {
        subNavList?.add(new SubNavItem.fromJson(v));
      });
    }
    salesBox = json['salesBox'] != null
        ? new SalesBox.fromJson(json['salesBox'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config?.toJson();
    }
    if (this.searchPlaceHolderList != null) {
      data['searchPlaceHolderList'] =
          this.searchPlaceHolderList?.map((v) => v.toJson()).toList();
    }
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList?.map((v) => v.toJson()).toList();
    }
    if (this.localNavList != null) {
      data['localNavList'] = this.localNavList?.map((v) => v.toJson()).toList();
    }
    if (this.gridNav != null) {
      data['gridNav'] = this.gridNav?.toJson();
    }
    if (this.subNavList != null) {
      data['subNavList'] = this.subNavList?.map((v) => v.toJson()).toList();
    }
    if (this.salesBox != null) {
      data['salesBox'] = this.salesBox?.toJson();
    }
    return data;
  }
}

class Config {
  String? searchUrl;

  Config({this.searchUrl});

  Config.fromJson(Map<String, dynamic> json) {
    searchUrl = json['searchUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchUrl'] = this.searchUrl;
    return data;
  }
}

class SearchPlaceHolderItem {
  String? text;

  SearchPlaceHolderItem({this.text});

  SearchPlaceHolderItem.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class BannerItem {
  String? icon;
  String? sIcon;
  String? url;

  BannerItem({this.icon, this.sIcon, this.url});

  BannerItem.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    sIcon = json['sIcon'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['sIcon'] = this.sIcon;
    data['url'] = this.url;
    return data;
  }
}

class LocalNavItem {
  String? icon;
  String? title;
  String? url;
  String? statusBarColor;
  bool? hideAppBar;

  LocalNavItem(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  LocalNavItem.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}

class GridNav {
  Hotel? hotel;
  Hotel? flight;
  Hotel? travel;

  GridNav({this.hotel, this.flight, this.travel});

  GridNav.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
    flight = json['flight'] != null ? new Hotel.fromJson(json['flight']) : null;
    travel = json['travel'] != null ? new Hotel.fromJson(json['travel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotel != null) {
      data['hotel'] = this.hotel?.toJson();
    }
    if (this.flight != null) {
      data['flight'] = this.flight?.toJson();
    }
    if (this.travel != null) {
      data['travel'] = this.travel?.toJson();
    }
    return data;
  }
}

class Hotel {
  String? startColor;
  String? endColor;
  LocalNavItem? mainItem;
  LocalNavItem? item1;
  LocalNavItem? item2;
  LocalNavItem? item3;
  LocalNavItem? item4;

  Hotel(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});

  Hotel.fromJson(Map<String, dynamic> json) {
    startColor = json['startColor'];
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null
        ? new LocalNavItem.fromJson(json['mainItem'])
        : null;
    item1 =
        json['item1'] != null ? new LocalNavItem.fromJson(json['item1']) : null;
    item2 =
        json['item2'] != null ? new LocalNavItem.fromJson(json['item2']) : null;
    item3 =
        json['item3'] != null ? new LocalNavItem.fromJson(json['item3']) : null;
    item4 =
        json['item4'] != null ? new LocalNavItem.fromJson(json['item4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    if (this.mainItem != null) {
      data['mainItem'] = this.mainItem?.toJson();
    }
    if (this.item1 != null) {
      data['item1'] = this.item1?.toJson();
    }
    if (this.item2 != null) {
      data['item2'] = this.item2?.toJson();
    }
    if (this.item3 != null) {
      data['item3'] = this.item3?.toJson();
    }
    if (this.item4 != null) {
      data['item4'] = this.item4?.toJson();
    }
    return data;
  }
}

class MainItem {
  String? title;
  String? icon;
  String? url;
  String? statusBarColor;

  MainItem({this.title, this.icon, this.url, this.statusBarColor});

  MainItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}

class Item {
  String? title;
  String? url;
  String? statusBarColor;

  Item({this.title, this.url, this.statusBarColor});

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}

class SubNavItem {
  String? icon;
  String? title;
  String? url;
  bool? hideAppBar;

  SubNavItem({this.icon, this.title, this.url, this.hideAppBar});

  SubNavItem.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}

class SalesBox {
  String? icon;
  String? moreUrl;
  SubNavItem? bigCard1;
  SubNavItem? bigCard2;
  SubNavItem? smallCard1;
  SubNavItem? smallCard2;
  SubNavItem? smallCard3;
  SubNavItem? smallCard4;

  SalesBox(
      {this.icon,
      this.moreUrl,
      this.bigCard1,
      this.bigCard2,
      this.smallCard1,
      this.smallCard2,
      this.smallCard3,
      this.smallCard4});

  SalesBox.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    moreUrl = json['moreUrl'];
    bigCard1 = json['bigCard1'] != null
        ? new SubNavItem.fromJson(json['bigCard1'])
        : null;
    bigCard2 = json['bigCard2'] != null
        ? new SubNavItem.fromJson(json['bigCard2'])
        : null;
    smallCard1 = json['smallCard1'] != null
        ? new SubNavItem.fromJson(json['smallCard1'])
        : null;
    smallCard2 = json['smallCard2'] != null
        ? new SubNavItem.fromJson(json['smallCard2'])
        : null;
    smallCard3 = json['smallCard3'] != null
        ? new SubNavItem.fromJson(json['smallCard3'])
        : null;
    smallCard4 = json['smallCard4'] != null
        ? new SubNavItem.fromJson(json['smallCard4'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['moreUrl'] = this.moreUrl;
    if (this.bigCard1 != null) {
      data['bigCard1'] = this.bigCard1?.toJson();
    }
    if (this.bigCard2 != null) {
      data['bigCard2'] = this.bigCard2?.toJson();
    }
    if (this.smallCard1 != null) {
      data['smallCard1'] = this.smallCard1?.toJson();
    }
    if (this.smallCard2 != null) {
      data['smallCard2'] = this.smallCard2?.toJson();
    }
    if (this.smallCard3 != null) {
      data['smallCard3'] = this.smallCard3?.toJson();
    }
    if (this.smallCard4 != null) {
      data['smallCard4'] = this.smallCard4?.toJson();
    }
    return data;
  }
}

class BigCard1 {
  String? icon;
  String? url;
  bool? hideAppBar;

  BigCard1({this.icon, this.url, this.hideAppBar});

  BigCard1.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}
