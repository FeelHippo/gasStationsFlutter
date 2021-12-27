import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autosense/data/models/station.dart';
import 'package:autosense/ui/home_page.dart';

import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

class StationForm extends StatefulWidget {
  const StationForm({Key? key, required this.station, required this.isNewStation}) : super(key: key);

  final Station station;
  final bool isNewStation;

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<StationForm> {

  String? name;
  String? address;
  String? city;

  Pump? pump;
  late List<Pump?> pumps;
  @override
  void initState() {
    super.initState();
    pumps = List.filled(3, pump);
  }


  bool formTouched = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void toggleFormIsTouched () {
    setState(() {
      formTouched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextFormField(
                initialValue: widget.station.name,
                onChanged: (inputText) {
                  toggleFormIsTouched();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field Required';
                  }
                  return null;
                },
                onSaved: (value) { name = value; },
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name...',
                  icon: Icon(Icons.local_gas_station_outlined),
                ),
              ),
              TextFormField(
                initialValue: widget.station.city,
                onChanged: (inputText) {
                  toggleFormIsTouched();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field Required';
                  }
                  return null;
                },
                onSaved: (value) { city = value; },
                decoration: const InputDecoration(
                  labelText: 'City',
                  hintText: 'City...',
                  icon: Icon(Icons.location_city_outlined),
                ),
              ),
              TextFormField(
                initialValue: widget.station.address,
                onChanged: (inputText) {
                  toggleFormIsTouched();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field Required';
                  }
                  return null;
                },
                onSaved: (value) { address = value; },
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'Address...',
                  icon: Icon(Icons.home_outlined),
                ),
              ),
              Row(
                children: widget.station.pumps.asMap().entries.map((pump) => Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.333,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: widget.station.pumps[pump.key].price.toString(),
                          onChanged: (inputText) {
                            toggleFormIsTouched();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field Required';
                            }
                            return null;
                          },
                          onSaved: (value) { pumps[pump.key]?.price = value; },
                          decoration: InputDecoration(
                            labelText: pump.value.fuel_type,
                            hintText: 'Type...',
                            icon: const Icon(Icons.water_outlined),
                          ),

                        )
                      ],
                    ),
                  ),
                )).toList()
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: formTouched == false ? null : () {
                      if (formTouched == true && _formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        if (widget.isNewStation) {
                          developer.log('New Station');
                          // Bloc to create station
                        } else {
                          developer.log('Update Station');
                          // Bloc call to update
                        }
                      }
                    },
                  ),
                  if (widget.isNewStation == false) SizedBox(width: 12),
                  if (widget.isNewStation == false) ElevatedButton(
                    child: const Text('Delete'),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('This station will be permanently deleted'),
                          content: const Text('Are you sure you want to proceed?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<StationsBloc>().add(DeleteStation(widget.station.id));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                );
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        )
                    )
                  )
                ],
              )
            ],
          )
      ),
    );
  }

}

