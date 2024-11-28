// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class DetailModel {
  final String sneakerid;
  final Uint8List image;
  DetailModel({
    required this.sneakerid,
    required this.image,
  });

  DetailModel copyWith({
    String? sneakerid,
    Uint8List? image,
  }) {
    return DetailModel(
      sneakerid: sneakerid ?? this.sneakerid,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sneakerid': sneakerid,
      'image': image,
    };
  }

  factory DetailModel.fromMap(Map<String, dynamic> map) {
    return DetailModel(
      sneakerid: map['sneakerid'] as String,
      image: map['image'] as Uint8List,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailModel.fromJson(String source) =>
      DetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DetailModel(sneakerid: $sneakerid, image: $image)';

  @override
  bool operator ==(covariant DetailModel other) {
    if (identical(this, other)) return true;

    return other.sneakerid == sneakerid && other.image == image;
  }

  @override
  int get hashCode => sneakerid.hashCode ^ image.hashCode;
}
