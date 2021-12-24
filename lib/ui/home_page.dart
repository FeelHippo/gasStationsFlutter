import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:autosense/data/models/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

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
    context.read<StationsBloc>().add(StationEvents.getStations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StationsBloc, StationsState>(
          builder: (BuildContext context, StationsState state) {
            if (state is StationsListError) {
              final error = state.error;
              String message = '${error.message}\nTap to Retry';
              return ElevatedButton(
                  child: Text('$message ...reload'),
                  onPressed: () {
                    _loadStations();
                  }
              );
            }
            if (state is StationsLoaded) {
              List<Station> stations = state.stations;
              return _list(stations);
            }
            return Text('loading...');
          }
      )
    );
  }

  Widget _list(List<Station> stations) {
    return Center(
      child: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (_, index) {
          Station station = stations[index];
          return Text(station.id, style: Theme.of(context).textTheme.headline5,);
        },
      ),
    );
  }
}