import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewDetailsScreen extends StatelessWidget {
  const ReviewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // બુકિંગ ફોર્મમાંથી આવતો ડેટા અહીં મેળવીશું
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
                  // જેટલા ગેસ્ટ હોય તેટલા આધાર કાર્ડ બતાવશે
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
                      Expanded(child: _buildReviewRow("CHECK-IN", DateFormat('yyyy-MM-dd').format(data['checkIn']))),
                      Expanded(child: _buildReviewRow("CHECK-OUT", DateFormat('yyyy-MM-dd').format(data['checkOut']))),
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
                    onPressed: () => _showSuccessDialog(context),
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

  // સફળતાનું પોપ-અપ (Photo 6 મુજબ)
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
