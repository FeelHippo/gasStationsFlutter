import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autosense/data/models/station.dart';
import 'package:autosense/ui/home_page.dart';
import 'package:flutter/services.dart';
import 'package:autosense/core/constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class StationForm extends StatefulWidget {
  const StationForm({Key? key, required this.station, required this.isNewStation}) : super(key: key);

  final Station station;
  final bool isNewStation;

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<StationForm> {

  bool formTouched = false;
  String _name = '';
  String _address = '';
  String _city = '';
  List<Pump> _pumps = [];
  @override
  void initState() {
    super.initState();
    _name = widget.station.name;
    _address = widget.station.address;
    _city = widget.station.city;
    _pumps = widget.station.pumps;
  }

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
                onSaved: (value) {
                  String nameValue = value ?? '';
                  setState(() {
                    _name = nameValue;
                  });
                },
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
                onSaved: (value) {
                  String cityValue = value ?? '';
                  setState(() {
                    _city = cityValue;
                  });
                },
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
                onSaved: (value) {
                  String addressValue = value ?? '';
                  setState(() {
                    _address = addressValue;
                  });
                },
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                            ],
                            initialValue: widget.station.pumps[pump.key].price == 0
                                ? null
                                : widget.station.pumps[pump.key].price.toString(),
                            onChanged: (inputText) {
                              toggleFormIsTouched();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty || value == '0') {
                                return 'Field Required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              String priceValue = value ?? '';
                              setState(() {
                                _pumps[pump.key].price = double.parse(num.parse(priceValue).toStringAsFixed(2));
                              });
                            },
                            decoration: InputDecoration(
                              labelText: fuelType['${pump.value.fuel_type}'],
                              hintText: 'Type...',
                            ),

                          ),
                        ),
                        Expanded(
                          child: FormField(
                            initialValue: widget.station.pumps[pump.key].available,
                            builder: (state) {
                              return Checkbox(
                                  value: _pumps[pump.key].available,
                                  onChanged: (value) {
                                    bool checkValue = value ?? false;
                                    setState(() {
                                      _pumps[pump.key].available = checkValue;
                                    });
                                    toggleFormIsTouched();
                                  }
                              );
                            },
                          )
                        ),
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
                        Station station = Station(
                          id: widget.station.id,
                          latitude: widget.station.latitude,
                          longitude: widget.station.longitude,
                          name: _name,
                          address: _address,
                          city: _city,
                          pumps: _pumps,
                        );

                        if (widget.isNewStation) {
                          context.read<StationsBloc>().add(CreateStation(station));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        } else {
                          context.read<StationsBloc>().add(UpdateStation(station));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => const AlertDialog(
                                title: Text('Please fill out all fields before saving'))
                        );
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

