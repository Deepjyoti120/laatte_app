import 'package:hive/hive.dart';

part 'location_model.g.dart'; 

@HiveType(typeId: 8)
class LocationModel extends HiveObject {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  DateTime timestamp;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });
}
