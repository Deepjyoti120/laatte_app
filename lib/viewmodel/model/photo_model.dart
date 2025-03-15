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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
