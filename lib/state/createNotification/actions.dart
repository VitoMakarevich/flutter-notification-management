import 'package:flutter_app/model/NotificationData.dart';

class EndCreateNotificationAction {}

class LoadingCreateNotificationAction {
  final NotificationData notificationData;

  LoadingCreateNotificationAction({this.notificationData});
}

class ErrorCreateNotificationAction {}