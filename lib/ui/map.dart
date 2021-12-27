import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:autosense/ui/form.dart';
import 'package:latlong2/latlong.dart';
import 'package:autosense/data/models/station.dart';

class StationsMap extends StatefulWidget {
  final List<Station> stations;

  const StationsMap({Key? key, required this.stations}) : super(key: key);

  @override
  _StationsMapState createState() => _StationsMapState();
}
class _StationsMapState extends State<StationsMap> {

  static void _showModalBottomSheet(BuildContext context, Station station, bool isNewStation) => showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<StationsBloc>(context),
          child: StationForm(station: station, isNewStation: isNewStation),
        );
      }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    _showModalBottomSheet(context, newStation, true);
                  }
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                    markers: widget.stations.map((station) => Marker(
                        width: 48,
                        height: 48,
                        point: LatLng(station.latitude, station.longitude),
                        builder: (context) => IconButton(
                          onPressed: () =>_showModalBottomSheet(context, station, false),
                          icon: const Icon(Icons.location_on, size: 48),
                        )
                    )).toList()
                ),
              ]
          )
      ),
    );
  }
}