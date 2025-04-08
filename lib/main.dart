import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/views/Auth/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';
import 'package:job_sky/views/home/bottom_nav_bar.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  final loggedIn = await isUserLoggedIn();
  runApp(ProviderScope(child: MyApp(isLoggedIn: loggedIn)) );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'JobSky',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0.0,
        )
      ),

      home:  isLoggedIn  ?  BottomNavBar() :  WelcomePage() ,
    );
  }
}
