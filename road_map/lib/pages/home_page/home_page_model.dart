import '/components/lock_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for lock component.
  late LockModel lockModel1;
  // Model for lock component.
  late LockModel lockModel2;

  @override
  void initState(BuildContext context) {
    lockModel1 = createModel(context, () => LockModel());
    lockModel2 = createModel(context, () => LockModel());
  }

  @override
  void dispose() {
    lockModel1.dispose();
    lockModel2.dispose();
  }
}
