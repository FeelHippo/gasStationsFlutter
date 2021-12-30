import 'dart:convert';
import 'dart:async';

import 'package:autosense/core/constants.dart';
import 'package:autosense/data/models/station.dart';
import 'package:autosense/data/app_exceptions.dart';
import 'package:autosense/data/models/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'dart:developer' as developer;

const timeout = Duration(seconds: 5);

class AppHttpManager  implements Repository {

  @override
  Future<List<Station>> get() async {
    try {
      final storage = new FlutterSecureStorage();
      final authentication = await http
        .post(
          _queryBuilder(authenticationEndpoint),
        headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
        },
        body: json.encode(<String, String>{
          'username': 'FlutterUser',
          'password': '123abc',
        })
      );

      String token = json.decode(authentication.body)['token'];
      await storage.write(key: 'JwtToken', value: token);

      print('Api Get request url $getEndpoint');
      final response = await http
          .get(
            _queryBuilder(getEndpoint),
          ).timeout(
            timeout,
            onTimeout: () => throw TimeoutException(),
          );
      return _returnResponse(response);
    } on Exception catch (_) {
      throw NetworkException('No Internet Connection');
    }
  }

  @override
  Future<bool> create(station) async {
    try {

      final jsonStation = Station(
        id: station.id,
        latitude: station.latitude,
        longitude: station.longitude,
        name: station.name,
        address: station.address,
        city: station.city,
        pumps: station.pumps,
      ).toJson();

      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'JwtToken');

      print('Api Create request $createEndpoint');
      final response = await http
          .post(
            _queryBuilder(createEndpoint),
            headers: <String, String>{
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              'Content-type': 'application/json',
            },
            body: json.encode(jsonStation),
          );
      return response.statusCode == 200;
    } on Exception catch (_) {
      throw NetworkException('No Internet Connection');
    }
  }

  @override
  Future<bool> update(station) async {
    try {

      final jsonStation = Station(
        id: station.id,
        latitude: station.latitude,
        longitude: station.longitude,
        name: station.name,
        address: station.address,
        city: station.city,
        pumps: station.pumps,
      ).toJson();

      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'JwtToken');

      print('Api Update request $updateEndpoint');
      final response = await http
        .put(
          _queryBuilder(updateEndpoint),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(jsonStation),
        );
      return response.statusCode == 200;
    } on Exception catch (_) {
      throw NetworkException('No Internet Connection');
    }
  }

  @override
  Future<bool> delete(stationId) async {
    try {

      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'JwtToken');

      print('Api Delete request $deleteEndpoint');
      final response = await http
        .delete(
          _queryBuilder('$deleteEndpoint/$stationId'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          }
        );
      return response.statusCode == 200;
    } on Exception catch (_) {
      throw NetworkException('No Internet Connection');
    }
  }

  Uri _queryBuilder(String path) {
    final buffer = StringBuffer()..write(apiUrl + path);
    return Uri.parse(buffer.toString());
  }

  dynamic _returnResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      List<Station> stations;
      stations = (json.decode(response.body) as List)
        .map((station) => Station.fromJson(station))
        .toList();
      print('Api response successful: $stations');
      return stations;
    }
    print('Error: Api response ${response.statusCode} + ${response.body}');
    switch(response.statusCode) {
      case 400:
        throw BadRequestException();
      case 401:
        throw ServerException();
      case 403:
        throw UnauthorisedException();
    }
  }

}

