// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  final int id;
  final String created_at;
  final String user;
  OrderModel({
    required this.id,
    required this.created_at,
    required this.user,
  });

  OrderModel copyWith({
    int? id,
    String? created_at,
    String? user,
  }) {
    return OrderModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'user': user,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      created_at: map['created_at'] as String,
      user: map['user'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OrderModel(id: $id, created_at: $created_at, user: $user)';

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.user == user;
  }

  @override
  int get hashCode => id.hashCode ^ created_at.hashCode ^ user.hashCode;
}
