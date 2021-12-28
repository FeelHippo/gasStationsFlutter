import 'package:autosense/data/models/station.dart';

abstract class Repository {
  Future<List<Station>> get();
  Future<bool> create(station);
  Future<bool> update(station);
  Future<bool> delete(stationId);
}