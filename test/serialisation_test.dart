import 'package:autosense/data/models/station.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Serialisation', () {
      test(
        'Station to serialised json',
          () async {

            final serial = Station(
                id: 'MIGROL_100099',
                name: 'Tankstelle SOCAR',
                address: 'Klotenerstrasse 46, 8303',
                city: 'Basserdorf',
                latitude: 47.44945112101852,
                longitude: 8.620147705078127,
                pumps: [
                  Pump(id: '10001', fuel_type: 'BENZIN_95', available: true, price: 1.71),
                  Pump(id: '10002', fuel_type: 'BENZIN_98', available: false, price: 1.69),
                  Pump(id: '10003', fuel_type: 'DIESEL', available: true, price: 1.75),
                ]
            ).toJson();

            final matcher = {
              "id": "MIGROL_100099",
              "name": "Tankstelle SOCAR",
              "address": "Klotenerstrasse 46, 8303",
              "city": "Basserdorf",
              "latitude": 47.44945112101852,
              "longitude": 8.620147705078127,
              "pumps": [
                { "id": "10001", "fuel_type": "BENZIN_95", "available": true, "price": 1.71 },
                { "id": "10002", "fuel_type": "BENZIN_98", "available": false, "price": 1.69 },
                { "id": "10003", "fuel_type": "DIESEL", "available": true, "price": 1.75 },
              ]
            };
            
            expect(serial, matcher);
          }
      );

      test(
        'Station is serialised from json',
          () async {
            final Map<String, dynamic> json = {
              "id": "MIGROL_100099",
              "name": "Tankstelle SOCAR",
              "address": "Klotenerstrasse 46, 8303",
              "city": "Basserdorf",
              "latitude": 47.44945112101852,
              "longitude": 8.620147705078127,
              "pumps": [
                { "id": "10001", "fuel_type": "BENZIN_95", "available": true, "price": 1.71 },
                { "id": "10002", "fuel_type": "BENZIN_98", "available": false, "price": 1.69 },
                { "id": "10003", "fuel_type": "DIESEL", "available": true, "price": 1.75 },
              ]
            };

            final actual = Station.fromJson(json);

            final serial = Station(
                id: 'MIGROL_100099',
                name: 'Tankstelle SOCAR',
                address: 'Klotenerstrasse 46, 8303',
                city: 'Basserdorf',
                latitude: 47.44945112101852,
                longitude: 8.620147705078127,
                pumps: [
                  Pump(id: '10001', fuel_type: 'BENZIN_95', available: true, price: 1.71),
                  Pump(id: '10002', fuel_type: 'BENZIN_98', available: false, price: 1.69),
                  Pump(id: '10003', fuel_type: 'DIESEL', available: true, price: 1.75),
                ]
            );

            expect(actual, serial);
          }
      );
    }
  );
}
