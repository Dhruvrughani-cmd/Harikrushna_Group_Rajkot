import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  // ૧. એડમિન નંબર્સની લિસ્ટ
  final List<String> adminNumbers = ['94097773955', '8799651611'];

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
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]
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
                    String phoneNumber = _phoneController.text.trim();

                    // ૨. લોજિક: જો ૧૦ આંકડા હોય તો જ આગળ વધશે
                    if (phoneNumber.length == 10) {
                      // ૩. ચેક કરો કે નંબર એડમિન લિસ્ટમાં છે કે નહીં
                      if (adminNumbers.contains(phoneNumber)) {
                        // એડમિન ડેશબોર્ડ પર મોકલો
                        Navigator.pushReplacementNamed(context, '/admin', arguments: phoneNumber);
                      } else {
                        // સામાન્ય યુઝરને હોમ પેજ પર મોકલો
                        Navigator.pushReplacementNamed(context, '/home', arguments: phoneNumber);
                      }
                    } else {
                      // જો નંબર ૧૦ આંકડાનો ન હોય તો મેસેજ બતાવશે
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a valid 10-digit number"))
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE67E22)),
                  child: const Text("Continue", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 15),
              // અહીં ક્લિક કરવાથી સીધું એડમિન લોગિનનો કોઈ અલગ રસ્તો રાખવાની હવે જરૂર નથી કારણ કે આપણે ઉપર જ લોજિક સેટ કરી દીધું છે.
              const Text("Admin Login", style: TextStyle(color: Color(0xFFE67E22), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
