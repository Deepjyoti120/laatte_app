import 'package:laatte/viewmodel/model/user_reports.dart';

class ChatHistory {
  String? id;
  String? uid;
  String? participantId;
  String? lastMsg;
  String? fileType;
  String? createdDate;
  String? updateDate;
  UserReport? users;
  UserReport? friend;

  ChatHistory({
    this.id,
    this.uid,
    this.participantId,
    this.lastMsg,
    this.fileType,
    this.createdDate,
    this.updateDate,
    this.users,
    this.friend,
  });

  ChatHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    participantId = json['participant_id'];
    lastMsg = json['last_msg'];
    fileType = json['file_type'];
    createdDate = json['created_date'];
    updateDate = json['update_date'];
    users = json['users'] != null ? UserReport.fromJson(json['users']) : null;
    friend =
        json['friend'] != null ? UserReport.fromJson(json['friend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['participant_id'] = participantId;
    data['last_msg'] = lastMsg;
    data['file_type'] = fileType;
    data['created_date'] = createdDate;
    data['update_date'] = updateDate;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    if (friend != null) {
      data['friend'] = friend!.toJson();
    }
    return data;
  }
}
