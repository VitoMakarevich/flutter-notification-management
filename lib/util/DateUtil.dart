import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static DateTime composeDateTimeAndTimeOfDay(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  static Future<DateTime> pickDateTime({
    context: BuildContext,
    initialDate: DateTime,
    firstDate: DateTime,
    lastDate: DateTime,
  }) async {
    DateTime pickedDay = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    if(pickedDay != null) {
      final nowTime = TimeOfDay.fromDateTime(initialDate);
      final time = await showTimePicker(
        context: context,
        initialTime: nowTime,
      );

      if(time != null) {
        final datetime = DateUtil.composeDateTimeAndTimeOfDay(pickedDay, time);
//        return '${DateFormat(DateFormat.MONTH_WEEKDAY_DAY).format(datetime)} ${DateFormat(DateFormat.HOUR_MINUTE).format(datetime)}';
        return datetime;
      }

      return null;
    }

    return null;
  }
}