import 'package:autosense/data/models/repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autosense/data/models/station.dart';
import 'package:autosense/bloc/gas_stations_bloc.dart';
import 'package:autosense/bloc/gas_station_events.dart';
import 'package:autosense/bloc/gas_stations_states.dart';

List<Station> expectedResult = [
  Station(
      id: 'MIGROL_TEST1',
      name: 'TEST 1',
      address: 'TEST 1',
      city: 'TEST 1',
      latitude: 50.12345678912345,
      longitude: 9.12345678912345,
      pumps: [
        Pump(id: '10001', fuel_type: 'BENZIN_95', available: true, price: 1.00),
        Pump(id: '10002', fuel_type: 'BENZIN_98', available: false, price: 2.00),
        Pump(id: '10003', fuel_type: 'DIESEL', available: true, price: 3.00),
      ]
  ),
  Station(
      id: 'MIGROL_TEST2',
      name: 'TEST 2',
      address: 'TEST 2',
      city: 'TEST 2',
      latitude: 50.12345678912345,
      longitude: 9.12345678912345,
      pumps: [
        Pump(id: '10001', fuel_type: 'BENZIN_95', available: true, price: 1.00),
        Pump(id: '10002', fuel_type: 'BENZIN_98', available: false, price: 2.00),
        Pump(id: '10003', fuel_type: 'DIESEL', available: true, price: 3.00),
      ]
  )
];


class MockAppHttpManager implements Repository {
  @override
  Future<List<Station>> get() async {
    return expectedResult;
  }

  @override
  Future<bool> create(station) async {
    if (station != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> update(station) async {
    if (station != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> delete(stationId) async {
    if (stationId != null) {
      return true;
    } else {
      return false;
    }
  }
}

main () {

  group('StationBloc', () {

    blocTest<StationsBloc, StationsState>(
      'Get all stations',
      build: () => StationsBloc(stationsRepository: MockAppHttpManager()),
      act: (bloc) => bloc.add(const GetStations()),
      expect: () => [
        StationsLoading(),
        StationsLoaded(stations: expectedResult),
      ],
    );

    blocTest<StationsBloc, StationsState>(
      'Create station',
      build: () => StationsBloc(stationsRepository: MockAppHttpManager()),
      act: (bloc) => bloc.add(CreateStation(Station(
          id: 'MIGROL_NEW',
          name: 'TEST NEW',
          address: 'TEST NEW',
          city: 'TEST NEW',
          latitude: 50.12345678912345,
          longitude: 9.12345678912345,
          pumps: [
            Pump(id: '10001', fuel_type: 'BENZIN_95', available: true, price: 1.00),
            Pump(id: '10002', fuel_type: 'BENZIN_98', available: false, price: 2.00),
            Pump(id: '10003', fuel_type: 'DIESEL', available: true, price: 3.00),
          ]
      ))),
      expect: () => [
        StationsLoading(),
        StationCreated(),
      ],
    );

    blocTest<StationsBloc, StationsState>(
      'Update station',
      build: () => StationsBloc(stationsRepository: MockAppHttpManager()),
      act: (bloc) => bloc.add(UpdateStation(Station(
          id: 'MIGROL_OLD',
          name: 'TEST OLD',
          address: 'TEST OLD',
          city: 'TEST OLD',
          latitude: 50.12345678912345,
          longitude: 9.12345678912345,
          pumps: [
            Pump(id: '10001', fuel_type: 'BENZIN_95', available: true, price: 1.00),
            Pump(id: '10002', fuel_type: 'BENZIN_98', available: false, price: 2.00),
            Pump(id: '10003', fuel_type: 'DIESEL', available: true, price: 3.00),
          ]
      ))),
      expect: () => [
        StationsLoading(),
        StationUpdated(),
      ],
    );

    blocTest<StationsBloc, StationsState>(
      'Delete station',
      build: () => StationsBloc(stationsRepository: MockAppHttpManager()),
      act: (bloc) => bloc.add(DeleteStation('MIGROL_TO_DELETE')),
      expect: () => [
        StationsLoading(),
        StationDeleted(),
      ],
    );

  });
}

