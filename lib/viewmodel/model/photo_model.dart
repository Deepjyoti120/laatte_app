class Photo {
  String? id;
  String? uid;
  String? photoUrl;
  String? caption;
  num? likes;
  String? uploadDate;
  String? createdDate;
  String? updateDate;
  String? galleryId;
  String? likeType;

  Photo({
    this.id,
    this.uid,
    this.photoUrl,
    this.caption,
    this.likes,
    this.uploadDate,
    this.createdDate,
    this.updateDate,
    this.galleryId,
    this.likeType,
  });

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    photoUrl = json['photo_url'];
    caption = json['caption'];
    likes = json['likes'];
    uploadDate = json['upload_date'];
    createdDate = json['created_date'];
    updateDate = json['update_date'];
    galleryId = json['gallery_id'];
    likeType = json['like_type'];
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
    data['gallery_id'] = galleryId;
    data['like_type'] = likeType;
    return data;
  }
}
