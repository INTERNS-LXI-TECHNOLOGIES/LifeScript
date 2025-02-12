import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  
  runApp(
    
    MaterialApp(
      title: 'Emergency Alerts',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => EmergencyBloc(),
child: EmergencyAlertApp(), // Fix the error here
      ),
    ));
    
}

// Emergency Alert Events
abstract class EmergencyEvent {}
class SendEmergencyAlert extends EmergencyEvent {}
class SendSilentAlert extends EmergencyEvent {}
class SendCheckIn extends EmergencyEvent {}

// Emergency Alert States
abstract class EmergencyState {}
class EmergencyInitial extends EmergencyState {}
class EmergencyLoading extends EmergencyState {}
class EmergencySuccess extends EmergencyState {}
class EmergencyFailure extends EmergencyState {}

// Emergency Bloc
class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  EmergencyBloc() : super(EmergencyInitial());

  @override
  Stream<EmergencyState> mapEventToState(EmergencyEvent event) async* {
    yield EmergencyLoading();
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating OpenAPI call
      yield EmergencySuccess();
    } catch (_) {
      yield EmergencyFailure();
    }
  }
}

class EmergencyAlertApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoleSelectionScreen()
      ;
  }
}

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _roleButton(context, 'Child', Icons.child_care, ChildHomeScreen()),
            _roleButton(context, 'Parent', Icons.supervisor_account, GPSMapScreen()),
            _roleButton(context, 'Parent', Icons.supervisor_account, ParentHomeScreen()),
            _roleButton(context, 'Teacher', Icons.school, TeacherHomeScreen()),
            _roleButton(context, 'Emergency Contact', Icons.local_hospital, EmergencyHomeScreen()),
          ],
        ),
      ),
    );
  }

  Widget _roleButton(BuildContext context, String role, IconData icon, Widget screen) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      icon: Icon(icon),
      label: Text(role),
    );
  }
}

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget body;
  BaseScreen({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: _buildDrawer(context),
      bottomNavigationBar: _buildBottomNavBar(),
      body: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 0,
        linearGradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
        ),
        borderGradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.2)],
        ),
        border: 2,
        blur: 10,
        child: body,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
          ListTile(title: Text('Settings'), onTap: () {}),
          ListTile(title: Text('Logout'), onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}

// Child UI
class ChildHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Child Dashboard',
      body: BlocConsumer<EmergencyBloc, EmergencyState>(
        listener: (context, state) {
          if (state is EmergencySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Action successful!')));
          } else if (state is EmergencyFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Action failed.')));
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emergencyButton(context, 'Emergency Alert', Icons.warning, Colors.red, SendEmergencyAlert()),
              _emergencyButton(context, 'Silent Alert', Icons.visibility_off, Colors.orange, SendSilentAlert()),
              _emergencyButton(context, 'Check-In', Icons.check_circle, Colors.green, SendCheckIn()),
            ],
          );
        },
      ),
    );
  }

  Widget _emergencyButton(BuildContext context, String text, IconData icon, Color color, EmergencyEvent event) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(minimumSize: Size(250, 60), backgroundColor: color),
      onPressed: () {
        BlocProvider.of<EmergencyBloc>(context).add(event);
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }
}

// Parent UI
class ParentHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Parent Dashboard',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Alerts & Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          _infoCard('Recent Alerts', Icons.notifications_active, Colors.blue),
          _infoCard('Geo-Fencing', Icons.map, Colors.green),
          _infoCard('Battery Level', Icons.battery_alert, Colors.red),
        ],
      ),
    );
  }

  Widget _infoCard(String text, IconData icon, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text),
      ),
    );
  }
}

// Teacher UI
class TeacherHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(title: 'Teacher Dashboard', body: Center(child: Text('Teacher Features')));
  }
}

// Emergency Contact UI
class EmergencyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(title: 'Emergency Contact Dashboard', body: Center(child: Text('Emergency Contact Features')));
  }
}
class GPSMapScreen extends StatefulWidget {
  @override
  _GPSMapScreenState createState() => _GPSMapScreenState();
}

class _GPSMapScreenState extends State<GPSMapScreen> {
  late GoogleMapController mapController;
  LatLng _gpsLocation = LatLng(37.7749, -122.4194); // Default to SF
  bool _isLoading = true;
  String googleMapApiKey = 'AIzaSyCAgWEZPfEGykaUhZ9dXMi4teofF35Sgi8';

  Future<void> fetchLocation() async {
    try {
      final response = await http.get(Uri.parse('http://172.22.160.1:8080/api/gps-entries'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
          print("API Response: $data");
        setState(() {
          _gpsLocation = LatLng(data['latitude'], data['longitude']);
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _gpsLocation, zoom: 14),
            onMapCreated: (controller) => mapController = controller,
            markers: {
              Marker(markerId: MarkerId("currentLocation"), position: _gpsLocation),
            },
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: GlassmorphicContainer(
              width: double.infinity,
              height: 150,
              borderRadius: 20,
              blur: 15,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderGradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.6), Colors.white.withOpacity(0.1)],
              ),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Current Location",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Lat: ${_gpsLocation.latitude}, Lng: ${_gpsLocation.longitude}",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}