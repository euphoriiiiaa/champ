// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavoriteModel {
  final int id;
  final String sneaker;
  final String user;
  FavoriteModel({
    required this.id,
    required this.sneaker,
    required this.user,
  });

  FavoriteModel copyWith({
    int? id,
    String? sneaker,
    String? user,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      sneaker: sneaker ?? this.sneaker,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sneaker': sneaker,
      'user': user,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as int,
      sneaker: map['sneaker'] as String,
      user: map['user'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromJson(String source) =>
      FavoriteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FavoriteModel(id: $id, sneaker: $sneaker, user: $user)';

  @override
  bool operator ==(covariant FavoriteModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.sneaker == sneaker && other.user == user;
  }

  @override
  int get hashCode => id.hashCode ^ sneaker.hashCode ^ user.hashCode;
}
