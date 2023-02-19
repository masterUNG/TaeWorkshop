// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModle {
  final String name;
  final String typeUser;
  final String email;
  final String password;
  final GeoPoint geoPoint;
  UserModle({
    required this.name,
    required this.typeUser,
    required this.email,
    required this.password,
    required this.geoPoint,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'typeUser': typeUser,
      'email': email,
      'password': password,
      'geoPoint': geoPoint,
    };
  }

  factory UserModle.fromMap(Map<String, dynamic> map) {
    return UserModle(
      name: (map['name'] ?? '') as String,
      typeUser: (map['typeUser'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      geoPoint: (map['geoPoint'] ?? const GeoPoint(0, 0)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModle.fromJson(String source) => UserModle.fromMap(json.decode(source) as Map<String, dynamic>);
}
