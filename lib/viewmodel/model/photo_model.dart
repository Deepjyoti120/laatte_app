class Photo {
  String? id;
  String? url;
  String? description;
  String? createdAt;

  Photo({this.id, this.url, this.description, this.createdAt});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['description'] = description;
    data['created_at'] = createdAt;
    return data;
  }
}
