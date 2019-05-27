import 'package:flutter/material.dart';
import 'package:flutter_app/model/NotificationData.dart';
import 'package:flutter_app/model/NetworkStatus.dart';
import 'package:flutter_app/common/CommonCard.dart';

class NotificationCard extends StatelessWidget {
  final NotificationData notificationData;

  NotificationCard(this.notificationData);

  String timeToStart() {
    final now = DateTime.now();
    final remainingDuration = notificationData.startDate.difference(now);
    final minutesRemaining = remainingDuration.inMinutes;

    if(minutesRemaining < 0) {
      return 'Outdated';
    } else if(minutesRemaining < 60) {
      return 'About ${minutesRemaining} mins remaining';
    } else {
      final hoursRemaining = remainingDuration.inHours;

      return 'About ${hoursRemaining} h remaining';
    }
  }

  String calculateDuration() {
    final duration = notificationData.endDate.difference(notificationData.startDate).inHours;

    return '${duration} h long';
  }

  Widget build(BuildContext context) {
    return CommonCard(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(notificationData.author),
              Text(timeToStart()),
              Text(calculateDuration()),
              Text(notificationData.text),
            ],
          ),
          ],
        )
    );
  }
}