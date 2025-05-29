import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/viewmodel/model/designation.dart';
import 'package:laatte/viewmodel/model/photo_model.dart';
part 'user_reports.g.dart';

@HiveType(typeId: 2)
class UserReport {
  @HiveField(0)
  String? id;
  @HiveField(1)
  bool? isActive;
  @HiveField(2)
  String? role;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? username;
  @HiveField(5)
  String? profilePicture;
  @HiveField(6)
  String? coverPicture;
  @HiveField(7)
  String? bio;
  @HiveField(8)
  bool? isVerified;
  @HiveField(9)
  String? name;
  @HiveField(10)
  String? firstName;
  @HiveField(11)
  String? middleName;
  @HiveField(12)
  String? lastName;
  @HiveField(13)
  String? countryCode;
  @HiveField(14)
  String? phone;
  @HiveField(15)
  String? dob;
  @HiveField(16)
  String? gender;
  @HiveField(17)
  String? doj;
  @HiveField(18)
  String? address;
  @HiveField(19)
  String? pincode;
  @HiveField(20)
  String? city;
  @HiveField(21)
  String? state;
  @HiveField(22)
  String? country;
  @HiveField(23)
  String? emergencyContact;
  @HiveField(24)
  String? fcmToken;
  @HiveField(25)
  String? createdAt;
  @HiveField(26)
  String? updatedAt;
  @HiveField(27)
  Designation? designation;
  @HiveField(28)
  bool? isProfileDone;
  @HiveField(29)
  List<Photo>? photos;
  @HiveField(30)
  String? occupation;
  @HiveField(31)
  String? education;

  UserReport({
    this.id,
    this.isActive,
    this.role,
    this.email,
    this.username,
    this.profilePicture,
    this.coverPicture,
    this.bio,
    this.isVerified,
    this.name,
    this.firstName,
    this.middleName,
    this.lastName,
    this.countryCode,
    this.phone,
    this.dob,
    this.gender,
    this.doj,
    this.address,
    this.pincode,
    this.city,
    this.state,
    this.country,
    this.emergencyContact,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.designation,
    this.isProfileDone,
    this.photos,
    this.occupation,
    this.education,
  });

  UserReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    role = json['role'];
    email = json['email'];
    username = json['username'];
    profilePicture = json['profile_picture'];
    coverPicture = json['cover_picture'];
    bio = json['bio'];
    isVerified = json['is_verified'];
    name = json['name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    dob = json['dob'];
    gender = json['gender'];
    doj = json['doj'];
    address = json['address'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    emergencyContact = json['emergency_contact'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'])
        : null;
    isProfileDone = json['is_profile_done'];
    if (json['photos'] != null) {
      photos = <Photo>[];
      json['photos'].forEach((v) {
        photos!.add(Photo.fromJson(v));
      });
    }
    occupation = json['occupation'];
    education = json['education'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_active'] = isActive;
    data['role'] = role;
    data['email'] = email;
    data['username'] = username;
    data['profile_picture'] = profilePicture;
    data['cover_picture'] = coverPicture;
    data['bio'] = bio;
    data['is_verified'] = isVerified;
    data['name'] = name;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['dob'] = dob;
    data['gender'] = gender;
    data['doj'] = doj;
    data['address'] = address;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['emergency_contact'] = emergencyContact;
    data['fcm_token'] = fcmToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    data['is_profile_done'] = isProfileDone;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    data['occupation'] = occupation;
    data['education'] = education;
    return data;
  }
}
