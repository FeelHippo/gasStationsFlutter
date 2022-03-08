import 'package:autosense/data/models/station.dart';
import 'package:equatable/equatable.dart';

abstract class StationEvent extends Equatable {
  const StationEvent();

  @override
  List<Object> get props => [];
}

class GetStations extends StationEvent {
  const GetStations();
}

class CreateStation extends StationEvent {
  const CreateStation({ required this.station });

  final Station station;

  @override
  List<Object> get props => [station];
  @override
  String toString() => 'CreateStation { name: ${station.name}, address: ${station.address}, city: ${station.city} }';
}

class UpdateStation extends StationEvent {
  const UpdateStation({ required this.station });

  final Station station;

  @override
  List<Object> get props => [station];
  @override
  String toString() => 'UpdateStation { name: ${station.name}, address: ${station.address}, city: ${station.city} }';
}

class DeleteStation extends StationEvent {
  const DeleteStation({ required this.stationId });

  final String stationId;

  @override
  List<Object> get props => [stationId];
  @override
  String toString() => 'DeleteStation { id: $stationId }';
}
