import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewDetailsScreen extends StatelessWidget {
  const ReviewDetailsScreen({super.key});

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
        'status': 'PENDING',
        'hotel_name': 'VRAJNIVAS HOTEL',
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
            const Text("Please verify your information before submitting.",
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReviewRow("FULL NAME", data['name']),
                  _buildReviewRow("MOBILE NUMBER", data['mobile']),
                  const Divider(),
                  const Text("AADHAAR NUMBERS", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 10),
                  ...(data['aadhaar'] as List).asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text("Guest ${entry.key + 1}: ${entry.value}", 
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    );
                  }).toList(),
                  const Divider(),
                  _buildReviewRow("GUESTS", "${data['guestCount']}"),
                  Row(
                    children: [
                      Expanded(child: _buildReviewRow("CHECK-IN", DateFormat('dd-MM-yyyy').format(data['checkIn']))),
                      Expanded(child: _buildReviewRow("CHECK-OUT", DateFormat('dd-MM-yyyy').format(data['checkOut']))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Edit Details"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _confirmAndSendData(context, data),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE67E22)),
                    child: const Text("Confirm Request", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
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
            const SizedBox(height: 20),
            const Text("Request Sent", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Your reservation request has been forwarded to the admin.", textAlign: TextAlign.center),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Return Home", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
