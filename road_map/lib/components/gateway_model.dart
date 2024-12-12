import '/components/second_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'gateway_widget.dart' show GatewayWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GatewayModel extends FlutterFlowModel<GatewayWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for second component.
  late SecondModel secondModel;

  @override
  void initState(BuildContext context) {
    secondModel = createModel(context, () => SecondModel());
  }

  @override
  void dispose() {
    secondModel.dispose();
  }
}
