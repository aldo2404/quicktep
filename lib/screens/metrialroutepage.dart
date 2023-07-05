import 'package:flutter/material.dart';
import 'package:quicktep/screens/Screenroute.dart';

class MaterialPageRoutes extends StatelessWidget {
  const MaterialPageRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: ScreenRouteGenerator.routeGenerator,
    );
  }
}
