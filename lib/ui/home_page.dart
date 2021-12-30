import 'package:autosense/ui/map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:autosense/style/autosense_theme.dart';
import 'package:autosense/data/models/station.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  _loadStations() async {
    context.read<StationsBloc>().add(const GetStations());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AutoSenseTheme.dark(),
        title: 'Gas Stations',
        home: BlocBuilder<StationsBloc, StationsState>(
            builder: (_, StationsState state) {
              if (state is StationsListError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: const Text('...reload'),
                        onPressed: () {
                          _loadStations();
                        }
                    )
                  ],
                );
              }
              if (
                state is StationCreated
                || state is StationUpdated
                || state is StationDeleted
              ) {
                _loadStations();
              }
              if (state is StationsLoaded) {
                List<Station> stations = state.stations;
                return StationsMap(stations: stations);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        )
    );
  }
}
