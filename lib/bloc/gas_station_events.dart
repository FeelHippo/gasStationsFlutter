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

class DeleteStation extends StationEvents {
  final String stationId;
  const DeleteStation(this.stationId);

  @override
  List<Object> get props => [];
  @override
  String toString() => 'DeleteStation { id: $stationId }';
}
