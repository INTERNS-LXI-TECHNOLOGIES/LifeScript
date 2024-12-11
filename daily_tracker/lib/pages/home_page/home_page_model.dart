import '/components/pepproni_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for pepproni component.
  late PepproniModel pepproniModel1;
  // Model for pepproni component.
  late PepproniModel pepproniModel2;
  // Model for pepproni component.
  late PepproniModel pepproniModel3;
  // Model for pepproni component.
  late PepproniModel pepproniModel4;
  // Model for pepproni component.
  late PepproniModel pepproniModel5;
  // Model for pepproni component.
  late PepproniModel pepproniModel6;
  // Model for pepproni component.
  late PepproniModel pepproniModel7;
  // Model for pepproni component.
  late PepproniModel pepproniModel8;

  @override
  void initState(BuildContext context) {
    pepproniModel1 = createModel(context, () => PepproniModel());
    pepproniModel2 = createModel(context, () => PepproniModel());
    pepproniModel3 = createModel(context, () => PepproniModel());
    pepproniModel4 = createModel(context, () => PepproniModel());
    pepproniModel5 = createModel(context, () => PepproniModel());
    pepproniModel6 = createModel(context, () => PepproniModel());
    pepproniModel7 = createModel(context, () => PepproniModel());
    pepproniModel8 = createModel(context, () => PepproniModel());
  }

  @override
  void dispose() {
    pepproniModel1.dispose();
    pepproniModel2.dispose();
    pepproniModel3.dispose();
    pepproniModel4.dispose();
    pepproniModel5.dispose();
    pepproniModel6.dispose();
    pepproniModel7.dispose();
    pepproniModel8.dispose();
  }
}
