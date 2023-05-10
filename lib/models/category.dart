// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String name;
  String id;
  String icon;
  int order;
  CategoryModel({
    required this.name,
    required this.id,
    required this.icon,
    required this.order,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'icon': icon,
      'order': order,
    };
  }

  factory CategoryModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return CategoryModel(
      name: documentSnapshot.data()!['name'] as String,
      id: documentSnapshot.data()!['id'] as String,
      icon: documentSnapshot.data()!['icon'] as String,
      order: documentSnapshot.data()!['order'] as int,
    );
  }

  String toJson() => json.encode(toMap());
}
