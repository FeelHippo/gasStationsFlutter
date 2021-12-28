import 'package:autosense/data/models/station.dart';
import 'package:equatable/equatable.dart';

abstract class StationEvents extends Equatable {
  const StationEvents();
}

class GetStations extends StationEvents {
  const GetStations();

  @override
  List<Object> get props => [];
}

class CreateStation extends StationEvents {
  final Station station;
  const CreateStation(this.station);

  @override
  List<Object> get props => [station];
  @override
  String toString() => 'CreateStation { name: ${station.name}, address: ${station.address}, city: ${station.city} }';
}

class UpdateStation extends StationEvents {
  final Station station;
  const UpdateStation(this.station);

  @override
  List<Object> get props => [station];
  @override
  String toString() => 'UpdateStation { name: ${station.name}, address: ${station.address}, city: ${station.city} }';
}

class DeleteStation extends StationEvents {
  final String stationId;
  const DeleteStation(this.stationId);

  @override
  List<Object> get props => [stationId];
  @override
  String toString() => 'DeleteStation { id: $stationId }';
}
