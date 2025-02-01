import '/flutter_flow/flutter_flow_util.dart';
import '../widget/calendarpage_widget.dart' show CalendarpageWidget;
import 'package:flutter/material.dart';

class CalendarpageModel extends FlutterFlowModel<CalendarpageWidget> {

  TabController? tabBarController;
  int get tabBarCurrentIndex => tabBarController != null ? tabBarController!.index : 0;

  DateTimeRange? calendarSelectedDay1;
  DateTimeRange? calendarSelectedDay2;

  @override
  void initState(BuildContext context) {

    calendarSelectedDay1 = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59),
    );

    calendarSelectedDay2 = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59),
    );
  }

  @override
  void dispose() {
  tabBarController?.dispose();
  }
}
