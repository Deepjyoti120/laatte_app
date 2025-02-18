class Friends {
  num? id;
  String? uid;
  String? name;
  String? profile;
  String? friendId;
  String? status;
  String? requestedAt;
  String? acceptedAt;
  String? createdDate;
  String? updateDate;

  Friends({
    this.id,
    this.uid,
    this.name,
    this.profile,
    this.friendId,
    this.status,
    this.requestedAt,
    this.acceptedAt,
    this.createdDate,
    this.updateDate,
  });

  Friends.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    profile = json['profile'];
    friendId = json['friend_id'];
    status = json['status'];
    requestedAt = json['requested_at'];
    acceptedAt = json['accepted_at'];
    createdDate = json['created_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['profile'] = profile;
    data['friend_id'] = friendId;
    data['status'] = status;
    data['requested_at'] = requestedAt;
    data['accepted_at'] = acceptedAt;
    data['created_date'] = createdDate;
    data['update_date'] = updateDate;
    return data;
  }
}
