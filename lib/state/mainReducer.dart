import 'package:flutter_app/state/notificationsList/reducers.dart';
import 'package:flutter_app/state/createNotification/reducers.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final NotificationState notificationListState;
  final CreateNotificationState createNotificationState;

  AppState({this.notificationListState, this.createNotificationState});
}

final initialState = new AppState(
  notificationListState: NotificationState.initial(),
  createNotificationState: CreateNotificationState.initial(),
);

AppState mainReducer(AppState state, action) => new AppState(
  notificationListState: notificationsListReducer(state.notificationListState, action),
  createNotificationState: createNotificationReducer(state.createNotificationState, action),
);