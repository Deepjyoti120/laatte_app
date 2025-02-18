import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/viewmodel/model/country_state.dart';
import 'package:laatte/viewmodel/model/department.dart';
part 'basic_info.g.dart';

@HiveType(typeId: 0)
class BasicInfo {
  @HiveField(0)
  List<String>? defaultRoles;
  @HiveField(1)
  Permissions? permissions;
  @HiveField(2)
  List<Department>? department;
  @HiveField(3)
  List<Country>? countries;
  @HiveField(4)
  List<String>? defaultGenders;

  BasicInfo({this.defaultRoles, this.permissions});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    defaultRoles = json['default_roles'].cast<String>();
    permissions = json['permissions'] != null
        ? Permissions.fromJson(json['permissions'])
        : null;
    if (json['department'] != null) {
      department = <Department>[];
      json['department'].forEach((v) {
        department!.add(Department.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Country>[];
      json['countries'].forEach((v) {
        countries!.add(Country.fromJson(v));
      });
    }
    defaultGenders = json['default_genders'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['default_roles'] = defaultRoles;
    if (permissions != null) {
      data['permissions'] = permissions!.toJson();
    }
    if (department != null) {
      data['department'] = department!.map((v) => v.toJson()).toList();
    }
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    data['default_genders'] = defaultGenders;
    return data;
  }
}

@HiveType(typeId: 1)
class Permissions {
  @HiveField(0)
  List<String>? modules;
  @HiveField(1)
  List<String>? features;

  Permissions({this.modules, this.features});

  Permissions.fromJson(Map<String, dynamic> json) {
    modules = json['modules'].cast<String>();
    features = json['features'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modules'] = modules;
    data['features'] = features;
    return data;
  }
}
