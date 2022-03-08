import 'dart:async';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/data/models/repository.dart';

class StationsBloc extends Bloc<StationEvent, StationsState> {

  final Repository stationsRepository;

  StationsBloc({ required this.stationsRepository }) : super(const StationsState.initial()) {
    on<GetStations>(_getStations);
    on<CreateStation>(_createStation);
    on<UpdateStation>(_updateStation);
    on<DeleteStation>(_deleteStation);
  }

  FutureOr<void> _getStations<StationEvent>(GetStations event, Emitter<StationsState> emit) async {
    try {
      final stations = await stationsRepository.get();
      if (stations.isNotEmpty) {
        emit(StationsState.fetch(stations));
      } else {
        emit(const StationsState.failure());
      }
    } catch (error) {
      emit(const StationsState.failure());
    }
  }

  FutureOr<void> _createStation<StationEvent>(CreateStation event, Emitter<StationsState> emit) async {
    try {
      final success = await stationsRepository.create(event.station);
      if (success) {
        emit(const StationsState.success());
      } else {
        emit(const StationsState.failure());
      }
    } catch (error) {
      emit(const StationsState.failure());
    }
  }

  FutureOr<void> _updateStation<StationEvent>(UpdateStation event, Emitter<StationsState> emit) async {
    try {
      final success = await stationsRepository.update(event.station);
      if (success) {
        emit(const StationsState.success());
      } else {
        emit(const StationsState.failure());
      }
    } catch (error) {
      emit(const StationsState.failure());
    }
  }

  FutureOr<void> _deleteStation<StationEvent>(DeleteStation event, Emitter<StationsState> emit) async {
    try {
      final success = await stationsRepository.delete(event.stationId);
      if (success) {
        emit(const StationsState.success());
      } else {
        emit(const StationsState.failure());
      }
    } catch (error) {
      emit(const StationsState.failure());
    }
  }
}
