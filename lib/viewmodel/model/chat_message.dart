import 'package:laatte/viewmodel/model/photo_model.dart';

class ChatMessage {
  String? id;
  String? chatId;
  String? uid;
  String? message;
  String? createdDate;
  String? updateDate;
  String? photoId;
  Photo? photo;

  ChatMessage({
    this.id,
    this.chatId,
    this.uid,
    this.message,
    this.createdDate,
    this.updateDate,
    this.photoId,
    this.photo,
  });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    uid = json['uid'];
    message = json['message'];
    createdDate = json['created_date'];
    updateDate = json['update_date'];
    photoId = json['photo_id'];
    photo = json['photos'] != null ? Photo.fromJson(json['photos']) : null;
    // if (json['photos'] != null) {
    //   photos = <Photo>[];
    //   json['photos'].forEach((v) {
    //     photos!.add(Photo.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chat_id'] = chatId;
    data['uid'] = uid;
    data['message'] = message;
    data['created_date'] = createdDate;
    data['update_date'] = updateDate;
    data['photo_id'] = photoId;
    // if (photo != null) {
    //   data['photos'] = photos!.map((v) => v.toJson()).toList();
    // }
    if (photo != null) {
      data['photos'] = photo!.toJson();
    }
    return data;
  }
}
