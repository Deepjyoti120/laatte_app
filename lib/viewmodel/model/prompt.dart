class Prompt {
  String? id;
  bool? isActive;
  String? prompt;
  List<String>? tags;
  String? bgPicture;
  num? commentCount;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  Prompt(
      {this.id,
      this.isActive,
      this.prompt,
      this.tags,
      this.bgPicture,
      this.commentCount,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  Prompt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    prompt = json['prompt'];
    tags = json['tags'].cast<String>();
    bgPicture = json['bg_picture'];
    commentCount = json['comment_count'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_active'] = isActive;
    data['prompt'] = prompt;
    data['tags'] = tags;
    data['bg_picture'] = bgPicture;
    data['comment_count'] = commentCount;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
