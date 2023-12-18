class StoreModel {
  late final String storeId, address, storename;
  late final int detailId;
  late final bool isOpen;
  LatLng? location;
  String? thumbnail;

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeId = json['uuid'];
    address = json['address'];
    thumbnail = json['thumbnail'];
    storename = json['storename'];
    detailId = json['detail'];
    isOpen = json['isOpen'];
    if (json['location'] != null) {
      location = LatLng.fromJson(json['location']);
    }
  }

  Map<String, dynamic> toJson() => {
        "uuid": storeId,
        "address": address,
        "thumbnail": thumbnail,
        "storename": storename,
        "detail": detailId,
        "isOpen": isOpen,
        "location": location?.toJson(),
      };
}

class StoreDetailModel {
  late final String phonenumber, parkinginfo, waytocome;
  late final List<dynamic> images;
  late final WeeklyHours openhours, sirenorderhours;
  String? description;

  StoreDetailModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    parkinginfo = json['parkinginfo'];
    waytocome = json['waytocome'];
    description = json['description'];
    images = json['images'] ?? [];
    openhours = WeeklyHours.fromJson(json['openhours']);
    sirenorderhours = WeeklyHours.fromJson(json['sirenorderhours']);
  }
}

class Hours {
  String? open, close;
  Hours(this.close, this.open);
  Hours.fromJson(Map<String, dynamic> json)
      : open = json['open'],
        close = json['close'];
}

class WeeklyHours {
  Hours? mon, tue, wed, thur, fri, sat, sun;
  WeeklyHours(
    this.mon,
    this.tue,
    this.wed,
    this.thur,
    this.fri,
    this.sat,
    this.sun,
  );
  WeeklyHours.fromJson(Map<String, dynamic> json)
      : mon = Hours.fromJson(json['mon']),
        tue = Hours.fromJson(json['tue']),
        wed = Hours.fromJson(json['wed']),
        thur = Hours.fromJson(json['thur']),
        fri = Hours.fromJson(json['fri']),
        sat = Hours.fromJson(json['sat']),
        sun = Hours.fromJson(json['sun']);
}

class LatLng {
  late final int latitude, longitude;
  LatLng.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'];
  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
