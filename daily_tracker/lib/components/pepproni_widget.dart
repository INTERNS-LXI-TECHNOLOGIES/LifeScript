import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pepproni_model.dart';
export 'pepproni_model.dart';

class PepproniWidget extends StatefulWidget {
  const PepproniWidget({super.key});

  @override
  State<PepproniWidget> createState() => _PepproniWidgetState();
}

class _PepproniWidgetState extends State<PepproniWidget> {
  late PepproniModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PepproniModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 50.0,
      child: Stack(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Color(0x4D000000),
                  offset: Offset(
                    0.0,
                    5.0,
                  ),
                  spreadRadius: 0.0,
                )
              ],
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB71C1C),
                  Color(0xFFEF5350),
                  Color(0xFFC62828)
                ],
                stops: [0.0, 0.5, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
              shape: BoxShape.circle,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.5, 0.15),
            child: Container(
              width: 15.0,
              height: 15.0,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Color(0x80000000),
                    offset: Offset(
                      0.0,
                      3.0,
                    ),
                    spreadRadius: 0.0,
                  )
                ],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
