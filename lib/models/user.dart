import '../services/utils.dart';

class Tester {

  final String uid;

  Tester({ required this.uid });

}

class UserField {

  static const String lastMessageTime = 'lastMessageTime';

}

class MainUser {
  final String uid;
  final String name;
  final String number;
  final String address;
  final int gender;
  final int function;
  final String urlAvatar;
  final DateTime? lastMessageTime;
  final List<dynamic> faculty;
  final List<dynamic> courses;

  MainUser({required this.uid, required this.name, required this.number,
    required this.address, required this.gender, required this.urlAvatar,
  required this.lastMessageTime ,required this.function,
    required this.faculty, required this.courses});

  MainUser copyWith({
    required String uid,
    required String name,
    required String number,
    required String address,
    required int gender,
    required int function,
    required String urlAvatar,
    required DateTime? lastMessageTime,
    required List<dynamic> faculty,
    required List<dynamic> courses,
  }) => MainUser(
    uid: uid,
    name: name,
    number: number,
    address: address,
    gender: gender,
    function: function,
    faculty: faculty,
    courses: courses,
    urlAvatar: urlAvatar,
    lastMessageTime: lastMessageTime as dynamic,
  );

  static MainUser fromJson(Map<String, dynamic> json) => MainUser(
    uid: json['uid'],
    name: json['name'],
    urlAvatar: json['urlAvatar'],
    lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
    number: json['number'],
    address: json['address'],
    function: json['function'],
    faculty: json['faculty'],
    courses: json['courses'],
    gender: json['gender'],
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'urlAvatar': urlAvatar,
    'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime!),
    'number': number,
    'address': address,
    'function': function,
    'faculty': faculty,
    'courses': courses,
    'gender': gender,
  };

}

