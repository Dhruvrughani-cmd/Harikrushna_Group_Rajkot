import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http; // Make.com માટે
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore માટે

class ReviewDetailsScreen extends StatelessWidget {
  const ReviewDetailsScreen({super.key});

  // ડેટા સેવ કરવાનું મુખ્ય ફંક્શન
  Future<void> _confirmAndSendData(BuildContext context, Map data) async {
    try {
      // ૧. Firestore માં ડેટા સેવ કરવો
      await FirebaseFirestore.instance.collection('bookings').add({
        'full_name': data['name'],
        'mobile': data['mobile'],
        'guest_count': data['guestCount'],
        'aadhaar_numbers': data['aadhaar'],
        'check_in': DateFormat('dd-MM-yyyy').format(data['checkIn']),
        'check_out': DateFormat('dd-MM-yyyy').format(data['checkOut']),
        'status': 'PENDING', // શરૂઆતમાં સ્ટેટસ પેન્ડિંગ રહેશે
        'timestamp': FieldValue.serverTimestamp(),
      });

      // ૨. Make.com Webhook પર ડેટા મોકલવો
      final url = Uri.parse('https://hook.eu1.make.com/y5oj58wqs5ggupy92uxffaugg0j25x3b');
      await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "hotel_name": "VRAJNIVAS HOTEL",
          "name": data['name'],
          "mobile": data['mobile'],
          "guests": data['guestCount'],
          "aadhaar": data['aadhaar'],
          "check_in": DateFormat('dd-MM-yyyy').format(data['checkIn']),
          "check_out": DateFormat('dd-MM-yyyy').format(data['checkOut']),
        }),
      );

      // ૩. સફળતાનું પોપ-અપ બતાવવું
      _showSuccessDialog(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: const Text("Review Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Please verify your information before submitting."),
            const SizedBox(height: 20),
            // ... (બાકીની કાર્ડ ડિઝાઇન જે તમે પહેલા બનાવી હતી તે જ રહેશે)
            ElevatedButton(
              onPressed: () => _confirmAndSendData(context, data), // અહીં ફંક્શન કોલ થશે
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE67E22)),
              child: const Text("Confirm Request", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.orange, size: 80),
            const Text("Request Sent", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Your reservation has been sent for approval.", textAlign: TextAlign.center),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
              child: const Text("Return Home"),
            ),
          ],
        ),
      ),
    );
  }
}
