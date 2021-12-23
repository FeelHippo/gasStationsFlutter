import 'dart:io';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/data/models/repository.dart';
import 'package:autosense/data/app_exceptions.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/data/models/station.dart';


class StationsBloc extends Bloc<StationEvents, StationsState> {
  final Repository stationsRepository;
  List<Station> stations = [];

  StationsBloc({ required this.stationsRepository }) : super(StationsInitState());

  @override
  Stream<StationsState> mapEventToState(StationEvents event) async* {
    switch (event) {
      case StationEvents.getStations:
        yield StationsLoading();
        try {
          stations = await stationsRepository.get();
          yield StationsLoaded(stations: stations);
        } on SocketException {
          yield StationsListError(
            error: NetworkException('No Internet Connection')
          );
        } on HttpException {
          yield StationsListError(
            error: NoServiceException('No Service Found')
          );
        } on FormatException {
          yield StationsListError(
            error:  InvalidFormatException('Invalid Response Format')
          );
        } catch (e) {
          yield StationsListError(
            error: GenericException('Unknown Error')
          );
        }
    }
  }
}