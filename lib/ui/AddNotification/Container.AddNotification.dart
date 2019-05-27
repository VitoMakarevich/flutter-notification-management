import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/model/NetworkStatus.dart';
import 'package:flutter_app/state/createNotification/actions.dart';
import 'package:flutter_app/state/mainReducer.dart';
import 'package:flutter_app/model/NotificationData.dart';
import 'package:flutter_app/ui/AddNotification/AddNotificatiton.dart';

class AddNotificationViewModel {
  final NetworkStatus status;
  final void Function(NotificationData notificationData) saveNotification;

  AddNotificationViewModel({this.saveNotification, this.status});
}

class AddNotificationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AddNotificationViewModel>(
        converter: (store) {
          return AddNotificationViewModel(
              status: store.state.createNotificationState.networkStatus,
              saveNotification: (NotificationData notificationData) =>
                  store.dispatch(LoadingCreateNotificationAction(
                      notificationData: notificationData)));
        },
        builder: (BuildContext context, AddNotificationViewModel vm) {
          return AddNotification(
            saveNotification: vm.saveNotification
          );
        });
  }
}
