import 'package:autosense/data/models/station.dart';

abstract class Repository {
  Future<List<Station>> get();
  Future<bool> delete(stationId);
}