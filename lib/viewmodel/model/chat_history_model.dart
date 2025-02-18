class ChatHistoryModel {
  int? id;
  String? uid;
  String? participantId;
  String? lastMsg;
  String? isFileType;
  String? createdDate;
  String? updateDate;

  ChatHistoryModel(
      {this.id,
      this.uid,
      this.participantId,
      this.lastMsg,
      this.isFileType,
      this.createdDate,
      this.updateDate});

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    participantId = json['participant_id'];
    lastMsg = json['last_msg'];
    isFileType = json['is_file_type'];
    createdDate = json['created_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['participant_id'] = participantId;
    data['last_msg'] = lastMsg;
    data['is_file_type'] = isFileType;
    data['created_date'] = createdDate;
    data['update_date'] = updateDate;
    return data;
  }
}
