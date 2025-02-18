import 'package:hive_flutter/hive_flutter.dart';
import 'department.dart';
part 'designation.g.dart';

@HiveType(typeId: 4)
class Designation {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? createdAt;
  @HiveField(4)
  String? updatedAt;
  @HiveField(5)
  Department? department;

  Designation(
      {this.id,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.department});

  Designation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (department != null) {
      data['department'] = department!.toJson();
    }
    return data;
  }
}
