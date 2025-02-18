class PhotosModel {
  String? id;
  String? uid;
  String? photoUrl;
  String? caption;
  int? likes;
  String? uploadDate;
  String? createdDate;
  String? updateDate;

  PhotosModel(
      {this.id,
      this.uid,
      this.photoUrl,
      this.caption,
      this.likes,
      this.uploadDate,
      this.createdDate,
      this.updateDate});

  PhotosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    photoUrl = json['photo_url'];
    caption = json['caption'];
    likes = json['likes'];
    uploadDate = json['upload_date'];
    createdDate = json['created_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['photo_url'] = photoUrl;
    data['caption'] = caption;
    data['likes'] = likes;
    data['upload_date'] = uploadDate;
    data['created_date'] = createdDate;
    data['update_date'] = updateDate;
    return data;
  }
}
