import 'package:flutter/material.dart';
import 'car_installment_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CarInstallmentUi(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/installment.png',
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Car Installment',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'คำนวณค่างวดรถยนต์',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 25),
                const CircularProgressIndicator(),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text('Created by NininD DTI-SAU'),
                Text('Version 1.0.0'),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
