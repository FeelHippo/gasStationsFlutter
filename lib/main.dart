import 'package:autosense/data/app_http_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'di.dart';
import 'style/autosense_theme.dart';
import 'package:autosense/ui/home_page.dart';

void main() {
  configureDependencies();
  runApp(
    MaterialApp(
      theme: AutoSenseTheme.dark(),
      title: 'Gas Stations',
      home: BlocProvider(
        create: (context) => StationsBloc(stationsRepository: AppHttpManager()),
        child: const HomePage(),
      ),
    )
  );
}
