import 'package:flutter/material.dart';
import 'package:autosense/data/models/station.dart';

import 'dart:developer' as developer;

class StationForm extends StatefulWidget {
  const StationForm({Key? key, required this.station}) : super(key: key);

  final Station station;

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
              Container(
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: formTouched == false ? null : () {
                    if (formTouched == true && _formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      bool isNewStation = widget.station.id == '';
                      if (isNewStation) {
                        // Bloc to create station
                      } else {
                        // Bloc call to update
                      }
                    }
                  },
                ),
              )
            ],
          )
      ),
    );
  }

}

