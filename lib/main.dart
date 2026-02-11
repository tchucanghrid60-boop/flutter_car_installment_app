import 'package:flutter/material.dart';
import 'package:flutter_car_installment_app/view/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    FlutterCarInstallmentApp(),
  );
}

class FlutterCarInstallmentApp extends StatefulWidget {
  const FlutterCarInstallmentApp({super.key});

  @override
  State<FlutterCarInstallmentApp> createState() =>
      _FlutterCarInstallmentAppState();
}

class _FlutterCarInstallmentAppState extends State<FlutterCarInstallmentApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
