
import 'package:laatte/viewmodel/model/user_reports.dart';

class Chat {
  String? id;
  String? createdAt;
  String? updatedAt;
  UserReport? user;
  LastMessage? lastMessage;

  Chat({this.id, this.createdAt, this.updatedAt, this.user , this.lastMessage});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserReport.fromJson(json['user']) : null;
    lastMessage = json['lastMessage'] != null
        ?   LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    return data;
  }
}

class LastMessage {
  String? id;
  String? content;
  bool? isRead;
  String? createdAt;

  LastMessage({this.id, this.content, this.isRead, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    return data;
  }
}
