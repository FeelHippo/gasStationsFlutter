import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:autosense/core/constants.dart';
import 'package:autosense/data/models/station.dart';
import 'package:autosense/data/app_exceptions.dart';
import 'package:autosense/data/models/repository.dart';
import 'package:autosense/data/models/station.dart';

import 'package:http/http.dart' as http;

const timeout = Duration(seconds: 3);

class AppHttpManager  implements Repository {

  @override
  Future<List<Station>> get() async {
    try {
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

