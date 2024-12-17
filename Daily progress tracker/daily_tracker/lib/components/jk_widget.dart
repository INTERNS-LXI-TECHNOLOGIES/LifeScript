import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'jk_model.dart';
export 'jk_model.dart';

class JkWidget extends StatefulWidget {
  const JkWidget({super.key});

  @override
  State<JkWidget> createState() => _JkWidgetState();
}

class _JkWidgetState extends State<JkWidget> {
  late JkModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JkModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 2.11),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/Download_Black_and_White_pizza_slice_hand_drawn_doodle_illustration_for_free_(1).jpeg',
          height: 400.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
