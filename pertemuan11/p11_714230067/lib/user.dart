import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class UserCreate {
  String? id;
  String name;
  String job;
  String? createdAt;
  String? updatedAt;

  UserCreate({
    this.id,
    required this.name,
    required this.job,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() => {'name': name, 'job': job};

  factory UserCreate.fromJson(Map<String, dynamic> json) {
    tz.initializeTimeZones();
    final jakarta = tz.getLocation('Asia/Jakarta');
    final now = DateFormat.yMd().add_jm().format(tz.TZDateTime.now(jakarta));

    return UserCreate(
      id: json['id'],
      name: json['name'],
      job: json['job'],
      createdAt: json.containsKey('createdAt') ? now : null,
      updatedAt: json.containsKey('updatedAt') ? now : null,
    );
  }
}
