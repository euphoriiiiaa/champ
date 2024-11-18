// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class SneakerModel {
  final String id;
  final String name;
  final double price;
  final int category;
  final String description;
  SneakerModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
  });

  SneakerModel copyWith({
    String? id,
    String? name,
    double? price,
    int? category,
    String? description,
  }) {
    return SneakerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
    };
  }

  factory SneakerModel.fromMap(Map<String, dynamic> map) {
    return SneakerModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: double.parse(map['price'].toString()),
      category: map['category'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SneakerModel.fromJson(String source) =>
      SneakerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SneakerModel(id: $id, name: $name, price: $price, category: $category, description: $description)';
  }

  @override
  bool operator ==(covariant SneakerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.category == category &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode;
  }
}
