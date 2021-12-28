import 'dart:io';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/data/models/station.dart';
import 'package:autosense/data/models/repository.dart';

class StationsBloc extends Bloc<StationEvents, StationsState> {

  List<Station> _stations = [];
  List<Station> get stations => _stations;
  final Repository stationsRepository;

  StationsBloc({ required this.stationsRepository }) : super(const StationsInitState(stations: []));

  @override
  Stream<StationsState> mapEventToState(StationEvents event) async* {
      if (event is GetStations) {
        yield* _mapGetStationsToState();
      }
      if (event is CreateStation) {
        yield* _mapCreateStationToState(event);
      }
      if (event is UpdateStation) {
        yield* _mapUpdateStationToState(event);
      }
      if (event is DeleteStation) {
        yield* _mapDeleteStationToState(event);
      }
  }

  Stream<StationsState> _mapGetStationsToState() async* {
    yield StationsLoading();
    try {
      _stations = await stationsRepository.get();
      yield StationsLoaded(stations: _stations);
    } on SocketException {
      yield StationsListError();
    } on HttpException {
      yield StationsListError();
    } on FormatException {
      yield StationsListError();
    } catch (e) {
      yield StationsListError();
    }
  }

  Stream<StationsState> _mapCreateStationToState(CreateStation event) async* {
    yield StationsLoading();
    try {
      await stationsRepository.create(event.station);
      yield const StationCreated();
    } on SocketException {
      yield StationsListError();
    } on HttpException {
      yield StationsListError();
    } on FormatException {
      yield StationsListError();
    } catch (e) {
      yield StationsListError();
    }
  }

  Stream<StationsState> _mapUpdateStationToState(UpdateStation event) async* {
    yield StationsLoading();
    try {
      await stationsRepository.update(event.station);
      yield const StationUpdated();
    } on SocketException {
      yield StationsListError();
    } on HttpException {
      yield StationsListError();
    } on FormatException {
      yield StationsListError();
    } catch (e) {
      yield StationsListError();
    }
  }

  Stream<StationsState> _mapDeleteStationToState(DeleteStation event) async* {
    yield StationsLoading();
    try {
      await stationsRepository.delete(event.stationId);
      yield const StationDeleted();
    } on SocketException {
      yield StationsListError();
    } on HttpException {
      yield StationsListError();
    } on FormatException {
      yield StationsListError();
    } catch (e) {
      yield StationsListError();
    }
  }
}
