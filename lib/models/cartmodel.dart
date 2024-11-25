// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:champ/models/sneakercartmodel.dart';
import 'package:champ/models/sneakermodel.dart';

class CartModel {
  final String id;
  final SneakerModel sneaker;
  final int count;
  CartModel({
    required this.id,
    required this.sneaker,
    required this.count,
  });

  CartModel copyWith({
    String? id,
    SneakerModel? sneaker,
    int? count,
  }) {
    return CartModel(
      id: id ?? this.id,
      sneaker: sneaker ?? this.sneaker,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sneaker': sneaker.toMap(),
      'count': count,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      sneaker: SneakerModel.fromMap(map['sneaker'] as Map<String, dynamic>),
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CartModel(id: $id, sneaker: $sneaker, count: $count)';

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.sneaker == sneaker && other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ sneaker.hashCode ^ count.hashCode;
}
