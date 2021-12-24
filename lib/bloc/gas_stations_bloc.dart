import 'dart:io';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/data/app_exceptions.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/data/models/station.dart';
import 'package:autosense/data/models/repository.dart';
import 'package:autosense/data/app_http_manager.dart';


class StationsBloc extends Bloc<StationEvents, StationsState> {

  List<Station> _stations = [];
  List<Station> get stations => _stations;
  final Repository stationsRepository;

  StationsBloc({ required this.stationsRepository }) : super(const StationsInitState(stations: []));

  @override
  Stream<StationsState> mapEventToState(StationEvents event) async* {
      if (event is GetStations) {
        yield StationsLoading(stations: _stations);
        try {
          _stations = await stationsRepository.get();
          yield StationsLoaded(stations: _stations);
        } on SocketException {
          yield StationsListError(stations: _stations);
        } on HttpException {
          yield StationsListError(stations: _stations);
        } on FormatException {
          yield StationsListError(stations: _stations);
        } catch (e) {
          yield StationsListError(stations: _stations);
        }
      }
  }
}