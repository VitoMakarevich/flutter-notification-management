import 'package:flutter_app/state/notificationsList/reducers.dart';
import 'package:flutter_app/state/notificationsList/actions.dart';
import 'package:flutter_app/state/mainReducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/api.dart';

class ListNotificationsEpic implements EpicClass<AppState>{
  final Api api;

  ListNotificationsEpic(this.api);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<LoadingNotificationAction>())
        .switchMap((action) => _loadNotifications());
  }

  Stream<dynamic> _loadNotifications() async* {
    try {
      var result = await this.api.loadLatestNotification();

      yield ReceiveNotificationAction(result);
    } catch (error) {
      yield ErrorNotificationAction();
    }
  }
}