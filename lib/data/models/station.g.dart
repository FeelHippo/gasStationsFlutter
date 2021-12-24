// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      id: json['id'] as String,
      name: json['name'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      pumps: (json['pumps'] as List<dynamic>)
          .map((e) => Pump.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'pumps': instance.pumps.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

Pump _$PumpFromJson(Map<String, dynamic> json) => Pump(
      id: json['id'] as String,
      fuel_type: json['fuel_type'] as String,
      price: json['price'],
      available: json['available'] as bool,
    );

Map<String, dynamic> _$PumpToJson(Pump instance) => <String, dynamic>{
      'id': instance.id,
      'fuel_type': instance.fuel_type,
      'price': instance.price,
      'available': instance.available,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      revision: json['revision'] as int,
      created: json['created'] as int,
      version: json['version'] as int,
      updated: json['updated'] as int?,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'revision': instance.revision,
      'created': instance.created,
      'version': instance.version,
      'updated': instance.updated,
    };
