import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/bloc/gas_station_observer.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/data/app_http_manager.dart';
import 'package:autosense/ui/home_page.dart';

void main() {
  BlocOverrides.runZoned(
      () => runApp(
        BlocProvider<StationsBloc>(
          create: (context) => StationsBloc(
              stationsRepository: AppHttpManager())
            ..add(const GetStations()),
          child: const HomePage(),
        )
      ),
    blocObserver: StationsBlocObserver(),
  );
}
