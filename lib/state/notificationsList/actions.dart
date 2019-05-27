import 'package:flutter_app/model/NotificationData.dart';

class StartLoadingNotificationAction {}

class ReceiveNotificationAction {
  final List<NotificationData> notificationData;

  ReceiveNotificationAction(this.notificationData);
}

class LoadingNotificationAction {}

class ErrorNotificationAction {}