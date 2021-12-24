import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:autosense/data/models/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
    return Scaffold(
      body: BlocBuilder<StationsBloc, StationsState>(
          builder: (BuildContext context, StationsState state) {
            if (state is StationsListError) {
              String message = 'Tap to Retry';
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
      child: FlutterMap(
          options: MapOptions(
            center: LatLng(47.373878, 8.545094),
            zoom: 10,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return const Text('© OpenStreetMap contributors');
                }
            ),
            MarkerLayerOptions(
                markers: stations.map((station) => Marker(
                    width: 48,
                    height: 48,
                    point: LatLng(station.latitude, station.longitude),
                    builder: (context) => const Icon(Icons.location_on, size: 48,)
                )).toList()
            ),
          ]
      )
    );
  }
}