import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quicktep/layoutproperty/buttonfield.dart';
import 'package:quicktep/screens/mappage/homescreen.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250),
          child: AppBar(
            flexibleSpace: ClipRRect(
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2))),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxTIEarJ5sWQCX2bc65_j0zmUapJspEYWIQw&usqp=CAU",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
      body: const SafeArea(
        child: Column(
          children: [
            Text(
              "Location permission not enabled",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 22),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Sharing Location permission helps us improve your ride booking and pickup experience",
                style: TextStyle(color: Colors.black54, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ReuseButton(
            onPressed: () {
              _locationPermission().then((value) {
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false);
                });
              });
            },
            text: "Allow Permission"),
      ),
    );
  }

  Future<Position> _locationPermission() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Location services are disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permission are permanently denied, we cannot request permission");
    }
    return await Geolocator.getCurrentPosition();
  }
}
