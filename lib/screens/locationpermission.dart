import 'package:flutter/material.dart';
import 'package:quicktep/layoutproperty/buttonfield.dart';

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
                    image: DecorationImage(
                  image: AssetImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxTIEarJ5sWQCX2bc65_j0zmUapJspEYWIQw&usqp=CAU"),
                )),
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
        child: ReuseButton(onPressed: () {}, text: "Allow Permission"),
      ),
    );
  }
}
