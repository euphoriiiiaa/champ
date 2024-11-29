// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderSneakersModel {
  final String id;
  final String sneaker;
  final int order;
  final int count;
  final String address;
  OrderSneakersModel({
    required this.id,
    required this.sneaker,
    required this.order,
    required this.count,
    required this.address,
  });

  OrderSneakersModel copyWith({
    String? id,
    String? sneaker,
    int? order,
    int? count,
    String? address,
  }) {
    return OrderSneakersModel(
      id: id ?? this.id,
      sneaker: sneaker ?? this.sneaker,
      order: order ?? this.order,
      count: count ?? this.count,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sneaker': sneaker,
      'order': order,
      'count': count,
      'address': address,
    };
  }

  factory OrderSneakersModel.fromMap(Map<String, dynamic> map) {
    return OrderSneakersModel(
      id: map['id'] as String,
      sneaker: map['sneaker'] as String,
      order: map['order'] as int,
      count: map['count'] as int,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSneakersModel.fromJson(String source) =>
      OrderSneakersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderSneakersModel(id: $id, sneaker: $sneaker, order: $order, count: $count, address: $address)';
  }

  @override
  bool operator ==(covariant OrderSneakersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sneaker == sneaker &&
        other.order == order &&
        other.count == count &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sneaker.hashCode ^
        order.hashCode ^
        count.hashCode ^
        address.hashCode;
  }
}
