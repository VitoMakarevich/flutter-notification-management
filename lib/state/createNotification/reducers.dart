import 'package:flutter_app/model/NetworkStatus.dart';
import 'package:flutter_app/model/NotificationData.dart';
import 'package:flutter_app/state/createNotification/actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class CreateNotificationState {
  final NetworkStatus networkStatus;

  CreateNotificationState({
    this.networkStatus,
  });

  factory CreateNotificationState.initial() => CreateNotificationState(
      networkStatus: NetworkStatus()
  );

  factory CreateNotificationState.error() => CreateNotificationState(
      networkStatus: NetworkStatus(error: true, loading: false)
  );

  factory CreateNotificationState.loading() => CreateNotificationState(
      networkStatus: NetworkStatus(loading: true, error: false)
  );
}

CreateNotificationState loadingCreateNotification(CreateNotificationState notificationState, LoadingCreateNotificationAction action) {
  return new CreateNotificationState.loading();
}

CreateNotificationState errorCreateNotification(CreateNotificationState notificationState, ErrorCreateNotificationAction action) {
  return new CreateNotificationState.error();
}

CreateNotificationState endCreateNotification(CreateNotificationState notificationState, EndCreateNotificationAction action) {
  return new CreateNotificationState(
    networkStatus: new NetworkStatus(
      loading: false,
    ),
  );
}

final createNotificationReducer = combineReducers<CreateNotificationState>([
  TypedReducer<CreateNotificationState, LoadingCreateNotificationAction>(loadingCreateNotification),
  TypedReducer<CreateNotificationState, ErrorCreateNotificationAction>(errorCreateNotification),
  TypedReducer<CreateNotificationState, EndCreateNotificationAction>(endCreateNotification)
]);