import '/components/jk_widget.dart';
import '/components/pepproni_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
import 'package:lottie/lottie.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int visibleSlices = 0; // Tracks how many slices are visible

  void incrementSlices() {
    setState(() {
      if (visibleSlices < 6) visibleSlices++; // Ensures only up to 6 slices are shown
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Stack(
                children: [
                   if (visibleSlices >= 1)
                  Transform.rotate(
                angle: -3.1416 / 3, // Adjusted angle to point inward
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.rotate(
                    angle: 3.1416, // Flip the slice inward
                    child: Lottie.asset(
                      'assets/jsons/pizza.json',
                      height: 625,
                      width: 315,
                    ),
                  ),
                ),
              ),
              // Slice 2
               if (visibleSlices >= 2)
              Transform.rotate(
                angle: -3.1416 / 3 + 1.0472, // Adjust for 60-degree step
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: Lottie.asset(
                      'assets/jsons/pizza.json',
                      height: 625,
                      width: 315,
                    ),
                  ),
                ),
              ),
              // Slice 3
               if (visibleSlices >= 3)
              Transform.rotate(
                angle: -3.1416 / 3 + 2.0944, // Step by 120 degrees
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: Lottie.asset(
                      'assets/jsons/pizza.json',
                      height: 625,
                      width: 315,
                    ),
                  ),
                ),
              ),
              // Slice 4
               if (visibleSlices >= 4)
              Transform.rotate(
                angle: -3.1416 / 3 + 3.1416, // Step by 180 degrees
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: Lottie.asset(
                      'assets/jsons/pizza.json',
                      height: 625,
                      width: 315,
                    ),
                  ),
                ),
              ),
              // Slice 5
               if (visibleSlices >= 5)
              Transform.rotate(
                angle: -3.1416 / 3 + 4.1888, // Step by 240 degrees
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: Lottie.asset(
                      'assets/jsons/pizza.json',
                      height: 625,
                      width: 315,
                    ),
                  ),
                ),
              ),
              // Slice 6
               if (visibleSlices >= 6)
              Transform.rotate(
                angle: -3.1416 / 3 + 5.2360, // Step by 300 degrees
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: Lottie.asset(
                      'assets/jsons/pizza.json',
                       height: 625,
                      width: 315,
                    ),
                  ),
                ),
              ),
                ],
              ),
               SizedBox(height: 30),
            // Increment Button
            ElevatedButton(
              onPressed: incrementSlices,
              child: Text(
                "Add Slice",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Slices: $visibleSlices / 6",
              style: TextStyle(fontSize: 18),
            ),
          
          
                
            ],
          ),
        ),
      ),
    );
  }
}
