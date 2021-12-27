import 'package:equatable/equatable.dart';
import 'package:autosense/data/models/station.dart';

abstract class StationsState extends Equatable {

  final List<Station>? stations;
  const StationsState({ this.stations });

  @override
  List<Object> get props => [];
}

class StationsInitState extends StationsState {
  final List<Station> stations;
  const StationsInitState({ required this.stations }) : super(stations: stations);
}
class StationsLoading extends StationsState {
  final List<Station> stations;
  const StationsLoading({ required this.stations }) : super(stations: stations);
}
class StationsLoaded extends StationsState {
  final List<Station> stations;
  StationsLoaded({ required this.stations }) : super(stations: stations);
}
class StationsListError extends StationsState {
  final List<Station> stations;
  StationsListError({ required this.stations }) : super(stations: stations);
}
class StationDeleted extends StationsState {
  const StationDeleted();
}
