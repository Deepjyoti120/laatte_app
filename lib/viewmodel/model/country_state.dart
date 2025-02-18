import 'package:hive_flutter/hive_flutter.dart';
part 'country_state.g.dart';

@HiveType(typeId: 5)
class Country {
  @HiveField(0)
  String? id;
  @HiveField(1)
  bool? isActive;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  String? updatedAt;
  @HiveField(6)
  List<CountryState>? states;

  Country(
      {this.id,
      this.isActive,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.states});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['states'] != null) {
      states = <CountryState>[];
      json['states'].forEach((v) {
        states!.add(CountryState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_active'] = isActive;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 6)
class CountryState {
  @HiveField(0)
  String? id;
  @HiveField(1)
  bool? isActive;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  String? updatedAt;

  CountryState({
    this.id,
    this.isActive,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  CountryState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_active'] = isActive;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
