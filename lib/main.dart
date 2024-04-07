import 'package:flutter/material.dart';
// import 'package:weathershare/splash/onboard.dart';
//import 'package:weathershare/splash/splash_screen.dart';
//import 'package:weathershare/screens/homescreen.dart';
import 'package:weathershare/utils/themes/theme.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_view.dart';
import 'package:get/get.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:go_router/go_router.dart'; // new
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // new

import 'app_state.dart'; // new
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const OnBoardingView(),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("weathershare/"),
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
