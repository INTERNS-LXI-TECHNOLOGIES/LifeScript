import 'package:communication/bloc/blocs/tongue_twister_bloc.dart';
import 'package:communication_openapi/openapi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class TongueTwister extends StatefulWidget {
  const TongueTwister({Key? key}) : super(key: key);

  @override
  _TongueTwisterState createState() => _TongueTwisterState();
}

class _TongueTwisterState extends State<TongueTwister> {
  late TongueTwisterBloc _tongueTwisterBloc;

  @override
  void initState() {
    super.initState();
    _tongueTwisterBloc = TongueTwisterBloc(
      openapi: Openapi(), // Initialize OpenAPI instance
      flutterTts: FlutterTts(),
    );

    // Fetch the tongue twister when the screen loads
    _tongueTwisterBloc.add(FetchText());
  }

  @override
  void dispose() {
    _tongueTwisterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _tongueTwisterBloc,
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/1200x/7d/11/d6/7d11d68858fa0cbb0b05a53df56a29ef.jpg'), // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Glassmorphic Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Glassmorphic Container for Sentence Display
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Please read the following sentence:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12),

                        // BlocBuilder to update UI based on state
                        BlocBuilder<TongueTwisterBloc, TongueTwisterState>(
                          builder: (context, state) {
                            if (state is TongueTwisterLoading) {
                              return CircularProgressIndicator(
                                  color: Colors.white);
                            } else if (state is TongueTwisterLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.text,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<TongueTwisterBloc>()
                                          .add(SpeakTextEvent(state.text));
                                    },
                                    child: Text("Speak"),
                                  ),
                                ],
                              );
                              // ignore: dead_code
                             
                            } else if (state is TongueTwisterError) {
                              return Text(
                                "Error: ${state.message}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32), // Spacer

                  // Microphone Button
                  GestureDetector(
                    onTap: () {
                      print(
                          "Mic button pressed"); // Placeholder for functionality
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.withOpacity(0.6),
                            Colors.blue.withOpacity(0.6),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),

                  SizedBox(height: 32), // Spacer

                  // Dashboard Section
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Performance Dashboard",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12), // Spacer
                        Text(
                          "Accuracy: 85%",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Total Recordings: 12",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Best Performance: 92%",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
