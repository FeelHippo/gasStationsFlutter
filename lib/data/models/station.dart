import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'station.g.dart';

@JsonSerializable(explicitToJson: true)
class Station extends Equatable  {
  final String id;
  final String name;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final List<Pump> pumps;

  Station({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.pumps,
  });

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);
  Map<String, dynamic> toJson() => _$StationToJson(this);

  @override
  List<Object> get props => [
    id,
    name,
    address,
    city,
    latitude,
    longitude,
    pumps,
  ];
}

@JsonSerializable(explicitToJson: true)
class Pump extends Equatable {
  final String id;
  final String fuel_type;
  dynamic price;
  bool available;

  Pump({
    required this.id,
    required this.fuel_type,
    this.price,
    required this.available,
  });

  factory Pump.fromJson(Map<String, dynamic> json) => _$PumpFromJson(json);
  Map<String, dynamic> toJson() => _$PumpToJson(this);

  @override
  List<Object> get props => [
    id,
    fuel_type,
    price,
    available,
  ];
}