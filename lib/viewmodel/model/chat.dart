
import 'package:laatte/viewmodel/model/user_reports.dart';

class Chat {
  String? id;
  String? createdAt;
  String? updatedAt;
  UserReport? user;

  Chat({this.id, this.createdAt, this.updatedAt, this.user});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserReport.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
