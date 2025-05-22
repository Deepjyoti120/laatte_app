import 'package:laatte/viewmodel/model/user_reports.dart';

class ChatStart {
  String? id;
  String? createdAt;
  String? updatedAt;
  UserReport? user1;
  UserReport? user2;

  ChatStart({this.id, this.createdAt, this.updatedAt, this.user1, this.user2});

  ChatStart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user1 = json['user1'] != null ? UserReport.fromJson(json['user1']) : null;
    user2 = json['user2'] != null ? UserReport.fromJson(json['user2']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user1 != null) {
      data['user1'] = user1!.toJson();
    }
    if (user2 != null) {
      data['user2'] = user2!.toJson();
    }
    return data;
  }
}