import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:quicktep/provider/auth_provider.dart';
//import 'package:quicktep/screens/mappage/homescreen.dart';
//import 'package:quicktep/screens/mapdummyscreen.dart';
//import 'package:quicktep/screens/Screenroute.dart';
// import 'package:quicktep/screens/metrialroutepage.dart';
import 'package:quicktep/screens/phoneauthpage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: 'phoneauth',
        // onGenerateRoute: ScreenRouteGenerator.routeGenerator,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const
            //MainMap()
            //HomeScreen(),
            PhoneAtuhPage(),
      ),
    );
  }
}
