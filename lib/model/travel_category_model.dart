class TravelCategoryModel {
  ResponseStatus? responseStatus;
  District? district;

  TravelCategoryModel({
    this.responseStatus,
    this.district,
  });

  TravelCategoryModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['ResponseStatus'] != null
        ? new ResponseStatus.fromJson(json['ResponseStatus'])
        : null;
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseStatus != null) {
      data['ResponseStatus'] = this.responseStatus?.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district?.toJson();
    }
    return data;
  }
}

class ResponseStatus {
  String? timestamp;
  String? ack;
  List<Null>? errors;
  List<Extension>? extension;

  ResponseStatus({this.timestamp, this.ack, this.errors, this.extension});

  ResponseStatus.fromJson(Map<String, dynamic> json) {
    timestamp = json['Timestamp'];
    ack = json['Ack'];
    if (json['Extension'] != null) {
      extension = [];
      json['Extension'].forEach((v) {
        extension?.add(new Extension.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Timestamp'] = this.timestamp;
    data['Ack'] = this.ack;
    if (this.extension != null) {
      data['Extension'] = this.extension?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Extension {
  String? id;
  String? value;

  Extension({this.id, this.value});

  Extension.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Value'] = this.value;
    return data;
  }
}

class District {
  int? districtId;
  String? districtName;
  List<TravelTab>? groups;

  District({this.districtId, this.districtName, this.groups});

  District.fromJson(Map<String, dynamic> json) {
    districtId = json['districtId'];
    districtName = json['districtName'];
    if (json['groups'] != null) {
      groups = [];
      json['groups'].forEach((v) {
        groups?.add(new TravelTab.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtId'] = this.districtId;
    data['districtName'] = this.districtName;
    if (this.groups != null) {
      data['groups'] = this.groups?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelTab {
  String? code;
  String? name;
  String? note;
  int? type;
  int? resourceType;

  TravelTab({this.code, this.name, this.note, this.type, this.resourceType});

  TravelTab.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    note = json['note'];
    type = json['type'];
    resourceType = json['resourceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['note'] = this.note;
    data['type'] = this.type;
    data['resourceType'] = this.resourceType;
    return data;
  }
}
