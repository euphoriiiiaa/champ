// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationModel {
  final int id;
  final String header;
  final String body;
  final DateTime created_at;
  final String user;
  final bool readed;
  NotificationModel({
    required this.id,
    required this.header,
    required this.body,
    required this.created_at,
    required this.user,
    required this.readed,
  });

  NotificationModel copyWith({
    int? id,
    String? header,
    String? body,
    DateTime? created_at,
    String? user,
    bool? readed,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      header: header ?? this.header,
      body: body ?? this.body,
      created_at: created_at ?? this.created_at,
      user: user ?? this.user,
      readed: readed ?? this.readed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'header': header,
      'body': body,
      'created_at': created_at.millisecondsSinceEpoch,
      'user': user,
      'readed': readed,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      header: map['header'] as String,
      body: map['body'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      user: map['user'] as String,
      readed: map['readed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, header: $header, body: $body, created_at: $created_at, user: $user, readed: $readed)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.header == header &&
        other.body == body &&
        other.created_at == created_at &&
        other.user == user &&
        other.readed == readed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        header.hashCode ^
        body.hashCode ^
        created_at.hashCode ^
        user.hashCode ^
        readed.hashCode;
  }
}
