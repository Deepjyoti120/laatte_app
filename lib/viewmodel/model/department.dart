import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/viewmodel/model/designation.dart';
part 'department.g.dart';

@HiveType(typeId: 3)
class Department {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? createdAt;
  @HiveField(4)
  String? updatedAt;
  @HiveField(5)
  List<Designation>? designations;

  Department({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.designations,
  });

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['designations'] != null) {
      designations = <Designation>[];
      json['designations'].forEach((v) {
        designations!.add(Designation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (designations != null) {
      data['designations'] = designations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
