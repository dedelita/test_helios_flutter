// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name']['first'] + json['name']['last'],
      gender: json['gender'],
      picture: json['picture']['large'],
      email: json['email'],
      address: Address.fromJson(json['location']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'picture': instance.picture,
      'email': instance.email,
      'address': instance.address,
    };
