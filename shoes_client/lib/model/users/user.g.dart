// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
  id: json['id'] as String?,
  name: json['name'] as String?,
  number: (json['number'] as num?)?.toInt(),
);

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'number': instance.number,
};
