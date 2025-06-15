import 'package:hive_flutter/hive_flutter.dart';
part 'photo_model.g.dart';

@HiveType(typeId: 7)
class Photo {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? url;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? createdAt;

  Photo({this.id, this.url, this.description, this.createdAt});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['description'] = description;
    data['created_at'] = createdAt;
    return data;
  }
}
