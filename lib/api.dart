import 'package:flutter_app/model/NotificationData.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Api {
  final String path;

  Api(this.path);

  Future<List<NotificationData>> loadLatestNotification () async {
    final response = await get('${this.path}/notificationData/');
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      final decoded = json.decode(response.body) as List<dynamic>;
      return decoded.map((jsonData) => NotificationData.fromJson(jsonData)).toList();
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<void> createNotification (NotificationData notificationData) async {
    final js = json.encode(new NotificationData(
      author: 'sdasd',
      id: 100,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      text: 'sdasd'
    ).toJson());
    final response = await post('${this.path}/notificationData/', body: js, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}