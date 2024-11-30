// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class OrderSneakersModel {
  final String id;
  final String sneaker;
  final int orderid;
  final int count;
  final Uint8List? image;
  final String? sneakername;
  final double? cost;
  OrderSneakersModel({
    required this.id,
    required this.sneaker,
    required this.orderid,
    required this.count,
    this.image,
    this.sneakername,
    this.cost,
  });

  OrderSneakersModel copyWith({
    String? id,
    String? sneaker,
    int? orderid,
    int? count,
    Uint8List? image,
    String? sneakername,
    double? cost,
  }) {
    return OrderSneakersModel(
      id: id ?? this.id,
      sneaker: sneaker ?? this.sneaker,
      orderid: orderid ?? this.orderid,
      count: count ?? this.count,
      image: image ?? this.image,
      sneakername: sneakername ?? this.sneakername,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sneaker': sneaker,
      'orderid': orderid,
      'count': count,
      'sneakername': sneakername,
      'cost': cost,
    };
  }

  factory OrderSneakersModel.fromMap(Map<String, dynamic> map) {
    return OrderSneakersModel(
      id: map['id'] as String,
      sneaker: map['sneaker'] as String,
      orderid: map['orderid'] as int,
      count: map['count'] as int,
      sneakername:
          map['sneakername'] != null ? map['sneakername'] as String : null,
      cost: map['cost'] != null ? map['cost'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSneakersModel.fromJson(String source) =>
      OrderSneakersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderSneakersModel(id: $id, sneaker: $sneaker, orderid: $orderid, count: $count, image: $image, sneakername: $sneakername, cost: $cost)';
  }

  @override
  bool operator ==(covariant OrderSneakersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sneaker == sneaker &&
        other.orderid == orderid &&
        other.count == count &&
        other.image == image &&
        other.sneakername == sneakername &&
        other.cost == cost;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sneaker.hashCode ^
        orderid.hashCode ^
        count.hashCode ^
        image.hashCode ^
        sneakername.hashCode ^
        cost.hashCode;
  }
}
