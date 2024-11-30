// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

class SneakerCartModel {
  final String id;
  final Uint8List? image;
  final String name;
  final double price;
  final int? category;
  final String? description;
  final bool? bestseller;
  final String? fullname;
  final int? count;
  SneakerCartModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.category,
    this.description,
    this.bestseller,
    this.fullname,
    this.count,
  });

  SneakerCartModel copyWith({
    String? id,
    Uint8List? image,
    String? name,
    double? price,
    int? category,
    String? description,
    bool? bestseller,
    String? fullname,
    int? count,
  }) {
    return SneakerCartModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
      bestseller: bestseller ?? this.bestseller,
      fullname: fullname ?? this.fullname,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'bestseller': bestseller,
      'fullname': fullname,
      'count': count,
    };
  }

  factory SneakerCartModel.fromMap(Map<String, dynamic> map) {
    return SneakerCartModel(
      id: map['id'] as String,
      image: map['image'] as Uint8List,
      name: map['name'] as String,
      price: map['price'] as double,
      category: map['category'] != null ? map['category'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      bestseller: map['bestseller'] != null ? map['bestseller'] as bool : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      count: map['count'] != null ? map['count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SneakerCartModel.fromJson(String source) =>
      SneakerCartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SneakerCartModel(id: $id, image: $image, name: $name, price: $price, category: $category, description: $description, bestseller: $bestseller, fullname: $fullname, count: $count)';
  }

  @override
  bool operator ==(covariant SneakerCartModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image == image &&
        other.name == name &&
        other.price == price &&
        other.category == category &&
        other.description == description &&
        other.bestseller == bestseller &&
        other.fullname == fullname &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode ^
        bestseller.hashCode ^
        fullname.hashCode ^
        count.hashCode;
  }
}
