import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        backgroundColor: const Color(0xFFE67E22), // તમારી થીમ મુજબનો ઓરેન્જ કલર
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Booking History",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // બુકિંગ કાર્ડ
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "VRAJNIVAS HOTEL",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Chip(
                        label: Text("PENDING", style: TextStyle(color: Colors.white, fontSize: 12)),
                        backgroundColor: Colors.orange,
                      ),
                    ],
                  ),
                  const Text("NON-AC ROOM", style: TextStyle(color: Colors.grey)),
                  const Divider(height: 25),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.orange),
                      SizedBox(width: 5),
                      Text("Status: Waiting for Admin Approval"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "તમારી વિનંતી મોકલાઈ ગઈ છે. હોટલ માલિક દ્વારા મંજૂર થયા પછી તમને જાણ કરવામાં આવશે.",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE67E22),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Back to Home", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
