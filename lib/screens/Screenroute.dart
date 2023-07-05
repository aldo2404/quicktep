import 'package:flutter/material.dart';
import 'package:quicktep/screens/creaateprofile.dart';
import 'package:quicktep/screens/mappage/homescreen.dart';
import 'package:quicktep/screens/locationpermission.dart';
import 'package:quicktep/screens/otpscreen.dart';
import 'package:quicktep/screens/phoneauthpage.dart';

class ScreenRouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings settings) {
    var dataargs = settings.arguments as String;

    switch (settings.name) {
      case '/phoneauth':
        return MaterialPageRoute(builder: (_) => const PhoneAtuhPage());
      case 'otpscreen':
        return MaterialPageRoute(
            builder: (_) => OtpScreen(
                  verificationId: dataargs,
                ));
      case 'profilescreen':
        return MaterialPageRoute(builder: (_) => const CreateUserProfile());
      case 'locationscreen':
        return MaterialPageRoute(
            builder: (_) => const LocationPermissionScreen());
      case 'homescreen':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
