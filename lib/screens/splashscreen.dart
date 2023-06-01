import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:provider/provider.dart';
// import 'package:quicktep/provider/auth_provider.dart';
// import 'package:quicktep/screens/homescreen.dart';
import 'package:quicktep/screens/phoneauthpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final ap = Provider.of<AuthProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        FlutterNativeSplash.remove();
      });

      // ap.isSignedIn == true
      //     ? Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const HomeScreen()))
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const PhoneAtuhPage())
          //  const MaterialPageRoutes()),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset("assets/images/quicktep2.png"),
    );
  }
}
