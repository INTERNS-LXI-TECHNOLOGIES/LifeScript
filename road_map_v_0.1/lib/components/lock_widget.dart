import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lock_model.dart';
export 'lock_model.dart';

class LockWidget extends StatefulWidget {
  const LockWidget({super.key});

  @override
  State<LockWidget> createState() => _LockWidgetState();
}

class _LockWidgetState extends State<LockWidget> {
  late LockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LockModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 32.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).tertiary,
            FlutterFlowTheme.of(context).warning
          ],
          stops: const [0.0, 1.0],
          begin: const AlignmentDirectional(0.0, -1.0),
          end: const AlignmentDirectional(0, 1.0),
        ),
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: FlutterFlowIconButton(
        buttonSize: 26.0,
        icon: Icon(
          Icons.lock_open,
          color: FlutterFlowTheme.of(context).primaryText,
          size: 16.0,
        ),
        onPressed: () {
          print('IconButton pressed ...');
        },
      ),
    );
  }
}
