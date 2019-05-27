import 'package:flutter/material.dart';
import 'package:flutter_app/ui/forms/NotificationForm.dart';
import 'package:flutter_app/model/NotificationData.dart';

class AddNotification extends StatelessWidget {
  final void Function(NotificationData notificationData) saveNotification;

  AddNotification({this.saveNotification});

  Future<void> submitForm(NotificationData notifData) async {
    saveNotification(notifData);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add notification'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: NotificationFormState(
            onSubmit: this.submitForm,
          ),
        ),
      )
    );
  }
}