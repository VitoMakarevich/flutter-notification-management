import 'package:flutter_app/state/createNotification/actions.dart';
import 'package:flutter_app/state/mainReducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:flutter_app/model/NotificationData.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/api.dart';

class CreateNotificationEpic implements EpicClass<AppState>{
  final Api api;

  CreateNotificationEpic(this.api);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<LoadingCreateNotificationAction>())
        .switchMap((action) => _createNotification(action.notificationData));
  }

  Stream<dynamic> _createNotification(NotificationData notificationData) async* {
    try {
      await this.api.createNotification(notificationData);

      yield EndCreateNotificationAction();
    } catch (error) {
      yield ErrorCreateNotificationAction();
    }
  }
}