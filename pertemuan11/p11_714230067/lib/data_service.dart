import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';

class DataService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-api-key': 'reqres_bbca121c38f748198e21e44314b34e2b',
      },
    ),
  );

  // GET RAW
  Future<dynamic> getUsers() async {
    try {
      final res = await dio.get('/users');
      return res.data;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // POST
  Future<UserCreate?> postUser(UserCreate user) async {
    try {
      final res = await dio.post('/users', data: user.toMap());
      if (res.statusCode == 201) {
        return UserCreate.fromJson(res.data);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // PUT ✅ FIX
  Future<UserCreate?> putUser(String id, String name, String job) async {
    try {
      final res = await dio.put(
        '/users/$id',
        data: {'name': name, 'job': job},
      );
      if (res.statusCode == 200) {
        return UserCreate.fromJson(res.data);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // DELETE
  Future<String?> deleteUser(String id) async {
    try {
      final res = await dio.delete('/users/$id');
      if (res.statusCode == 204) return 'Delete user success';
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // GET MODEL
  Future<List<User>?> getUserModel() async {
    try {
      final res = await dio.get('/users');
      final List data = res.data['data'];
      return data.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
