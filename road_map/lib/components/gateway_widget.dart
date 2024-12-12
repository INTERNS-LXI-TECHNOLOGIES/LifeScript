import '/components/second_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'gateway_model.dart';
export 'gateway_model.dart';

class GatewayWidget extends StatefulWidget {
  const GatewayWidget({super.key});

  @override
  State<GatewayWidget> createState() => _GatewayWidgetState();
}

class _GatewayWidgetState extends State<GatewayWidget> {
  late GatewayModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GatewayModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return wrapWithModel(
      model: _model.secondModel,
      updateCallback: () => safeSetState(() {}),
      child: SecondWidget(),
    );
  }
}
