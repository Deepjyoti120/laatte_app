import 'package:laatte/viewmodel/model/irl.dart';

class VisitIrl {
	String? id;
	bool? isActive;
	bool? isAvailabe;
	bool? isWeekAvailabe;
	String? latitude;
	String? longitude;
	String? visitDate;
	String? createdAt;
	String? updatedAt;
	Irl? irl;

	VisitIrl({this.id, this.isActive, this.latitude, this.longitude, this.visitDate, this.createdAt, this.updatedAt, this.irl});

	VisitIrl.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		isActive = json['is_active'];
		isAvailabe = json['is_availabe'];
		isWeekAvailabe = json['is_week_availabe'];
		latitude = json['latitude'];
		longitude = json['longitude'];
		visitDate = json['visit_date'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		irl = json['irl'] != null ? Irl.fromJson(json['irl']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['is_active'] = isActive;
    data['is_availabe'] = isAvailabe;
    data['is_week_availabe'] = isWeekAvailabe;
		data['latitude'] = latitude;
		data['longitude'] = longitude;
		data['visit_date'] = visitDate;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		if (irl != null) {
      data['irl'] = irl!.toJson();
    }
		return data;
	}
}

