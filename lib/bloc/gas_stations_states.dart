import 'package:equatable/equatable.dart';
import 'package:autosense/data/models/station.dart';

abstract class StationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class StationsInitState extends StationsState {}
class StationsLoading extends StationsState {}
class StationsLoaded extends StationsState {
  final List<Station> stations;
  StationsLoaded({ required this.stations });
}
class StationsListError extends StationsState {
  final error;
  StationsListError({ this.error });
}
