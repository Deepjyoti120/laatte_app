import 'package:laatte/viewmodel/model/irl.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';

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
  List<Comment>? comments;
  UserReport? user;
  Irl? irl;
  String? type;

  Prompt({
    this.id,
    this.isActive,
    this.prompt,
    this.tags,
    this.bgPicture,
    this.commentCount,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.comments,
    this.user,
    this.irl,
    this.type,
  });

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
    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(new Comment.fromJson(v));
      });
    }
    user = json['user'] != null ? UserReport.fromJson(json['user']) : null;
    irl = json['irl'] != null ? Irl.fromJson(json['irl']) : null;
    type = json['type'];
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
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (irl != null) {
      data['irl'] = irl!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class Comment {
  String? id;
  String? comment;
  String? createdAt;
  String? updatedAt;
  UserReport? user;

  Comment({this.id, this.comment, this.createdAt, this.updatedAt, this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserReport.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
