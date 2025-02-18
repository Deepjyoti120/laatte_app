class ChatMessages {
  int? id;
  int? chatId;
  String? uid;
  String? message;
  String? createdDate;
  String? updateDate;

  ChatMessages(
      {this.id,
      this.chatId,
      this.uid,
      this.message,
      this.createdDate,
      this.updateDate});

  ChatMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    uid = json['uid'];
    message = json['message'];
    createdDate = json['created_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chat_id'] = chatId;
    data['uid'] = uid;
    data['message'] = message;
    data['created_date'] = createdDate;
    data['update_date'] = updateDate;
    return data;
  }
}
