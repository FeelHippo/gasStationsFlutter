import 'package:json_annotation/json_annotation.dart';
part 'station.g.dart';

// List<Station> stationFromJson(String station) => List<Station>.from(json.decode(station).map((s) => Station.fromJson(s)).toList());
// String stationToJson(List<Station> data) => json.encode(List<Station>.from(data.map((field) => field.toJson())));

@JsonSerializable(explicitToJson: true)
class Station {
  final String id;
  final String? name;
  final String? address;
  final String? city;
  final double latitude;
  final double longitude;
  final List<Pump> pumps;

  Station({
    required this.id,
    this.name,
    this.address,
    this.city,
    required this.latitude,
    required this.longitude,
    required this.pumps,
  });

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);
  Map<String, dynamic> toJson() => _$StationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pump {
  final String id;
  final String fuel_type;
  dynamic price;
  final bool available;

  Pump({
    required this.id,
    required this.fuel_type,
    this.price,
    required this.available,
  });

  factory Pump.fromJson(Map<String, dynamic> json) => _$PumpFromJson(json);
  Map<String, dynamic> toJson() => _$PumpToJson(this);
}
