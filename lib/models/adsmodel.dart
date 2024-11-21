// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdsModel {
  final String id;
  AdsModel({
    required this.id,
  });

  AdsModel copyWith({
    String? id,
  }) {
    return AdsModel(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory AdsModel.fromMap(Map<String, dynamic> map) {
    return AdsModel(
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdsModel.fromJson(String source) =>
      AdsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AdsModel(id: $id)';

  @override
  bool operator ==(covariant AdsModel other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
