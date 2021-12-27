import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_stations_states.dart';
import 'package:autosense/data/app_http_manager.dart';
import 'package:autosense/style/autosense_theme.dart';
import 'package:autosense/data/models/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:autosense/ui/form.dart';
import 'package:latlong2/latlong.dart';

import 'dart:developer' as developer;


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
              if (state is StationDeleted) {
                _loadStations();
              }
              if (state is StationsLoaded) {
                List<Station> stations = state.stations;
                return _list(stations);
              }
              return const Text('loading...');
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
            onTap: (position, coordinates) {
              Station newStation = Station(
                  id: '',
                  latitude: coordinates.latitude,
                  longitude: coordinates.longitude,
                  pumps: ['BENZIN_95', 'BENZIN_98', 'DIESEL']
                      .asMap().entries.map((type) => Pump(
                        id: '1000${type.key + 1}',
                        fuel_type: type.value,
                        available: true,
                        price: 0,
                  )).toList(),
              );
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: BlocProvider.of<StationsBloc>(context),
                      child: StationForm(station: newStation, isNewStation: true),
                    );
                  }
              );
            }
          ),
          layers: [
            TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
                markers: stations.map((station) => Marker(
                    width: 48,
                    height: 48,
                    point: LatLng(station.latitude, station.longitude),
                    builder: (context) => Scaffold(

                      body: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: BlocProvider.of<StationsBloc>(context),
                                    child: StationForm(station: station, isNewStation: false),
                                  );
                                }
                            );
                          },
                          icon: const Icon(Icons.location_on, size: 48)
                      ),
                    )
                )).toList()
            ),
          ]
      )
    );
  }
}