import '/flutter_flow/flutter_flow_util.dart';
import '../widget/habittrack_homepage_widgetwidget.dart'  show HabittrackhomepagewidgetWidget;
import 'package:flutter/material.dart';


class HabittrackhomepagewidgetModel extends FlutterFlowModel<HabittrackhomepagewidgetWidget> with ChangeNotifier {
  
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  
  DateTime? startDate;
  DateTime? endDate;

  double? sliderValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();

    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }

  void updateStartDate(DateTime newDate) {
    startDate = newDate;
    notifyListeners(); 
  }

  void updateEndDate(DateTime newDate) {
    endDate = newDate;
    notifyListeners();
  }

  void updateSliderValue(double newValue) {
    sliderValue = newValue;
    notifyListeners(); 
  }
}
