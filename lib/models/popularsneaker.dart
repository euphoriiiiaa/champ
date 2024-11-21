// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PopularSneaker {
  final int id;
  final String sneaker;
  PopularSneaker({
    required this.id,
    required this.sneaker,
  });

  PopularSneaker copyWith({
    int? id,
    String? sneaker,
  }) {
    return PopularSneaker(
      id: id ?? this.id,
      sneaker: sneaker ?? this.sneaker,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sneaker': sneaker,
    };
  }

  factory PopularSneaker.fromMap(Map<String, dynamic> map) {
    return PopularSneaker(
      id: map['id'] as int,
      sneaker: map['sneaker'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularSneaker.fromJson(String source) =>
      PopularSneaker.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PopularSneaker(id: $id, sneaker: $sneaker)';

  @override
  bool operator ==(covariant PopularSneaker other) {
    if (identical(this, other)) return true;

    return other.id == id && other.sneaker == sneaker;
  }

  @override
  int get hashCode => id.hashCode ^ sneaker.hashCode;
}
