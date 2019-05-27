import 'package:flutter_app/model/NetworkStatus.dart';
import 'package:flutter_app/model/NotificationData.dart';
import 'package:flutter_app/state/notificationsList/actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class NotificationState {
  final NetworkStatus networkStatus;
  final List<NotificationData> notificationData;

  NotificationState({
    this.networkStatus,
    this.notificationData
  });

  factory NotificationState.initial() => NotificationState(
    notificationData: [],
    networkStatus: NetworkStatus()
  );

  factory NotificationState.error() => NotificationState(
    networkStatus: NetworkStatus(error: true, loading: false)
  );

  factory NotificationState.loading() => NotificationState(
    networkStatus: NetworkStatus(loading: true, error: false)
  );
}

NotificationState loadingNotification(NotificationState notificationState, LoadingNotificationAction action) {
  return new NotificationState.loading();
}

NotificationState errorNotification(NotificationState notificationState, ErrorNotificationAction action) {
  return new NotificationState.error();
}

NotificationState receivedNotification(NotificationState notificationState, ReceiveNotificationAction action) {
  return new NotificationState(
    notificationData: action.notificationData,
    networkStatus: new NetworkStatus(
      loading: false,
    ),
  );
}

final notificationsListReducer = combineReducers<NotificationState>([
  TypedReducer<NotificationState, LoadingNotificationAction>(loadingNotification),
  TypedReducer<NotificationState, ErrorNotificationAction>(errorNotification),
  TypedReducer<NotificationState, ReceiveNotificationAction>(receivedNotification)
]);