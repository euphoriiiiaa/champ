// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class SneakerModel {
  final String id;
  final String name;
  final double price;
  final int? category;
  final String? description;
  final bool? bestseller;
  final String? fullname;
  SneakerModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.bestseller,
    required this.fullname,
  });

  SneakerModel copyWith({
    String? id,
    String? name,
    double? price,
    int? category,
    String? description,
    bool? bestseller,
    String? fullname,
  }) {
    return SneakerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
      bestseller: bestseller ?? this.bestseller,
      fullname: fullname ?? this.fullname,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'bestseller': bestseller,
      'fullname': fullname,
    };
  }

  factory SneakerModel.fromMap(Map<String, dynamic> map) {
    return SneakerModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: double.parse(map['price'].toString()),
      category: map['category'] as int,
      description: map['description'] as String,
      bestseller: map['bestseller'] as bool,
      fullname: map['fullname'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SneakerModel.fromJson(String source) =>
      SneakerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SneakerModel(id: $id, name: $name, price: $price, category: $category, description: $description, bestseller: $bestseller, fullname: $fullname)';
  }

  @override
  bool operator ==(covariant SneakerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.category == category &&
        other.description == description &&
        other.bestseller == bestseller &&
        other.fullname == fullname;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode ^
        bestseller.hashCode ^
        fullname.hashCode;
  }
}
