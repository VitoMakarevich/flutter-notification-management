import 'package:flutter/material.dart';
import 'package:flutter_app/util/DateUtil.dart';
import 'package:flutter_app/model/NotificationData.dart';
import 'package:intl/intl.dart';

class NotificationFormState extends StatefulWidget {
  Function onSubmit;
  static final formKey =
      GlobalKey<FormState>(debugLabel: 'AddNotificationForm');

  NotificationFormState({this.onSubmit}) {}

  NotificationData _notificationData = NotificationData();

  void changeStart(DateTime start) {
    _notificationData.startDate = start;
  }

  void changeEnd(DateTime end) {
    _notificationData.endDate = end;
  }

  void handleSubmit() {
    final form = NotificationFormState.formKey;
    if (form.currentState.validate()) {
      this.onSubmit(this._notificationData);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return NotificationForm();
  }
}

class NotificationForm extends State<NotificationFormState> {
  NotificationData _notificationData = NotificationData();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  Future<void> handleStartDatePicker(BuildContext context) async {
    final nowDateTime = DateTime.now();
    final maxDateTime = nowDateTime.add(Duration(days: 30));
    final formattedDate = await DateUtil.pickDateTime(
      context: context,
      initialDate: nowDateTime,
      lastDate: maxDateTime,
      firstDate: nowDateTime,
    );

    if (formattedDate != null) {
      widget.changeStart(formattedDate);
      this._startDateController.text =
          NotificationForm.formatDate(formattedDate);
    }
  }

  static String formatDate(DateTime datetime) {
    return '${DateFormat(DateFormat.MONTH_WEEKDAY_DAY).format(datetime)} ${DateFormat(DateFormat.HOUR_MINUTE).format(datetime)}';
  }

  Future<void> handleEndDatePicker(BuildContext context) async {
    final nowDateTime = DateTime.now();
    final maxDateTime = nowDateTime.add(Duration(days: 30));

    final formattedDate = await DateUtil.pickDateTime(
      context: context,
      initialDate: nowDateTime,
      lastDate: maxDateTime,
      firstDate: nowDateTime,
    );

    if (formattedDate != null) {
      widget.changeEnd(formattedDate);
      this._endDateController.text = NotificationForm.formatDate(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key: NotificationFormState.formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          controller: this._startDateController,
                          decoration: InputDecoration(
                            labelText: 'Start data',
                            alignLabelWithHint: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Value should be specified';
                            }
                          },
                          enabled: false,
                        ),
                      ),
                      IconButton(
                        icon:
                            Icon(IconData(59670, fontFamily: 'MaterialIcons')),
                        onPressed: () => this.handleStartDatePicker(context),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          controller: this._endDateController,
                          decoration: InputDecoration(
                            labelText: 'End data',
                            errorStyle: TextStyle(
                              color: Colors.red,
                            ),
                            alignLabelWithHint: true,
                          ),
                          enabled: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Value should be specified';
                            } else if (widget._notificationData.startDate != null &&
                                widget._notificationData.endDate
                                    .isBefore(widget._notificationData.startDate)) {
                              return 'Value should be after start date';
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon:
                            Icon(IconData(59670, fontFamily: 'MaterialIcons')),
                        onPressed: () => this.handleEndDatePicker(context),
                      ),
                    ],
                  ),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Text',
                      errorStyle: TextStyle(
                        color: Colors.red,
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Create'),
                onPressed: () => widget.handleSubmit(),
              )
            ],
          )
        ]);
  }
}
