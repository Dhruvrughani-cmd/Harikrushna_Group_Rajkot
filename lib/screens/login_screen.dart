import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(20), 
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Welcome", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text("Sign in to manage your stay", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixText: "+91 ", 
                  hintText: "Enter 10-digit number",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // જો નંબર ૧૦ આંકડાનો હોય તો જ હોમ પેજ પર જવા દેશે
                    if (_phoneController.text.length == 10) {
                      Navigator.pushReplacementNamed(context, '/home', arguments: _phoneController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE67E22)),
                  child: const Text("Continue", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 15),
              const Text("Admin Login", style: TextStyle(color: Color(0xFFE67E22), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
