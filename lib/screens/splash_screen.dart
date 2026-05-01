import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ૩ સેકન્ડ પછી હોમ સ્ક્રીન પર જશે
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE67E22), // હોટલ થીમ ઓરેન્જ કલર
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hotel, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "VRAJNIVAS HOTEL",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text("NON-AC ROOM", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
