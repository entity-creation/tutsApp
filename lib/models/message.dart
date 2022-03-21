import 'package:tuts_app/services/utils.dart';

class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  final String uid;
  final String recUid;
  final String urlAvatar;
  final String name;
  final String message;
  final DateTime? createdAt;

  const Message({
    required this.uid,
    required this.recUid,
    required this.urlAvatar,
    required this.name,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        uid: json['uid'],
        recUid: json['recUid'],
        urlAvatar: json['urlAvatar'],
        name: json['name'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'recUid': recUid,
        'urlAvatar': urlAvatar,
        'name': name,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
      };
}
