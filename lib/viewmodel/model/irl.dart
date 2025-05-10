
import 'package:laatte/viewmodel/model/user_reports.dart';

class Irl {
	String? id;
	bool? isActive;
	String? name;
	String? type;
	String? description;
	String? profile;
	ServiceArea? serviceArea;
	String? countryCode;
	String? phone;
	String? latitude;
	String? longitude;
	String? email;
	String? address;
	UserReport? owner;

	Irl({this.id, this.isActive, this.name, this.type, this.description, this.profile, this.serviceArea, this.countryCode, this.phone, this.latitude, this.longitude, this.email, this.address, this.owner});

	Irl.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		isActive = json['is_active'];
		name = json['name'];
		type = json['type'];
		description = json['description'];
		profile = json['profile'];
		serviceArea = json['service_area'] != null ? ServiceArea.fromJson(json['service_area']) : null;
		countryCode = json['country_code'];
		phone = json['phone'];
		latitude = json['latitude'];
		longitude = json['longitude'];
		email = json['email'];
		address = json['address'];
		owner = json['owner'] != null ?   UserReport.fromJson(json['owner']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['is_active'] = isActive;
		data['name'] = name;
		data['type'] = type;
		data['description'] = description;
		data['profile'] = profile;
		if (serviceArea != null) {
      data['service_area'] = serviceArea!.toJson();
    }
		data['country_code'] = countryCode;
		data['phone'] = phone;
		data['latitude'] = latitude;
		data['longitude'] = longitude;
		data['email'] = email;
		data['address'] = address;
		if (owner != null) {
      data['owner'] = owner!.toJson();
    }
		return data;
	}
}

class ServiceArea {
  final String type;
  final List<List<List<double>>> coordinates;

  ServiceArea({
    required this.type,
    required this.coordinates,
  });

  factory ServiceArea.fromJson(Map<String, dynamic> json) {
    return ServiceArea(
      type: json['type'],
      coordinates:  (List<List<List<double>>>.from(
        json['coordinates'].map((x) => List<List<double>>.from(
          x.map((y) => List<double>.from(y.map((z) => z.toDouble()))),
        )),
      )),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}