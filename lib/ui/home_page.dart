import 'package:autosense/ui/map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:autosense/style/autosense_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AutoSenseTheme.dark(),
        title: 'Gas Stations',
        home: BlocBuilder<StationsBloc, StationsState>(
            builder: (_, StationsState state) {
              if (state.status == StationsAppState.failure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: const Text('...reload'),
                        onPressed: () {
                          context.read<StationsBloc>().add(const GetStations());
                        }
                    )
                  ],
                );
              }
              if (state.status == StationsAppState.fetch) {
                context.read<StationsBloc>().add(const GetStations());
                return const StationsMap();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        )
    );
  }
}
