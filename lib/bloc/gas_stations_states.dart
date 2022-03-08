import 'package:equatable/equatable.dart';
import 'package:autosense/data/models/station.dart';

enum StationsAppState {
  initial,
  fetch,
  success,
  failure,
}

class StationsState extends Equatable {
  const StationsState._({
    required this.status,
    this.stations = const [],
  });

  const StationsState.initial() : this._(status: StationsAppState.initial);
  const StationsState.fetch(fetchedStations) : this._(status: StationsAppState.fetch, stations: fetchedStations);
  const StationsState.success() : this._(status: StationsAppState.success);
  const StationsState.failure() : this._(status: StationsAppState.failure);

  final StationsAppState status;
  final List<Station> stations;

  @override
  List<Object> get props => [status, stations];
}
