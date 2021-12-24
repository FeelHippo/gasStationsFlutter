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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: widget.station.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field Required';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.station.address,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field Required';
              }
              return null;
            },
          ),
          Container(
            child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('ADD BLOC EVENT TO UPDATE STATION');
                  developer.log('${widget.station.name}');
                }
              },
            ),
          )
        ],
      )
    );
  }

}

