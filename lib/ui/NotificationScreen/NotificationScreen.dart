import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/state/notificationsList/reducers.dart';
import 'package:flutter_app/state/notificationsList/actions.dart';
import 'package:flutter_app/state/mainReducer.dart';
import 'package:flutter_app/ui/NotificationScreen/NotificationCard.dart';
import 'package:flutter_app/model/NotificationData.dart';
import 'package:flutter_app/model/NetworkStatus.dart';

class AppStateViewModel {
  final NotificationState state;
  final void Function() load;

  AppStateViewModel({this.state, this.load});
}

class NotificationScreenState extends StatefulWidget {
  NetworkStatus networkStatus;
  List<NotificationData> notificationData;
  Function() load;

  NotificationScreenState(this.notificationData, this.networkStatus, this.load);

  @override
  State<StatefulWidget> createState() => NotificationScreenComponent();
}

class NotificationScreenComponent extends State<NotificationScreenState> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.networkStatus.loading
          ? Container(
              alignment: Alignment.center, child: CircularProgressIndicator())
          : widget.notificationData.length > 0
              ? Column(
                  children: widget.notificationData
                      .map((item) => NotificationCard(item))
                      .toList(),
                )
              : Text('No notifications'),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppStateViewModel>(converter: (store) {
      return AppStateViewModel(
          state: store.state.notificationListState,
          load: () => store.dispatch(LoadingNotificationAction()));
    }, builder: (BuildContext context, AppStateViewModel vm) {
      return Scaffold(
        body: NotificationScreenState(
            vm.state.notificationData, vm.state.networkStatus, vm.load),
        appBar: AppBar(
          title: Text('Notification'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addNotification'),
          child: Icon(IconData(57669, fontFamily: 'MaterialIcons')),
        ),
      );
    });
  }
}
