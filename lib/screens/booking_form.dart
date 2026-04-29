import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  int guestCount = 1; // ડિફોલ્ટ ૧ વ્યક્તિ
  DateTime? checkIn;
  DateTime? checkOut;
  
  // આધાર કાર્ડના નંબર સાચવવા માટે
  List<TextEditingController> aadhaarControllers = [TextEditingController()];

  void _updateGuests(int delta) {
    setState(() {
      int newCount = guestCount + delta;
      if (newCount >= 1 && newCount <= 3) {
        guestCount = newCount;
        if (delta > 0) {
          aadhaarControllers.add(TextEditingController());
        } else {
          aadhaarControllers.removeLast();
        }
        @override
  Widget build(BuildContext context) {
    final String mobile = ModalRoute.of(context)!.settings.arguments as String? ?? "9033291948";

    return Scaffold(
      appBar: AppBar(title: const Text("Reservation Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("FULL NAME"),
            const TextField(decoration: InputDecoration(hintText: "Enter your full name")),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("MOBILE NUMBER"),
                      const SizedBox(height: 10),
                      Text(mobile, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("NUMBER OF GUESTS"),
                      Row(
                        children: [
                          Text("$guestCount", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_drop_up, size: 30),
                                onPressed: guestCount < 3 ? () => _updateGuests(1) : null,
                              ),
                              if (guestCount > 1)
                                IconButton(
                                  icon: const Icon(Icons.arrow_drop_down, size: 30),
                                  onPressed: () => _updateGuests(-1),
                                ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Guest Aadhaar Details", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...List.generate(guestCount, (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: aadhaarControllers[index],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Guest ${index + 1} Aadhaar Number",
                  border: const OutlineInputBorder(),
                ),
              ),
            )),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CHECK-IN DATE"),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(checkIn == null ? "dd-mm-yyyy" : DateFormat('dd-MM-yyyy').format(checkIn!)),
                        trailing: const Icon(Icons.calendar_today_outlined),
                        onTap: _selectCheckIn,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CHECK-OUT DATE"),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(checkOut == null ? "dd-mm-yyyy" : DateFormat('dd-MM-yyyy').format(checkOut!)),
                        trailing: const Icon(Icons.calendar_today_outlined),
                        onTap: _selectCheckOut,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE67E22),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Review Booking", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- તારીખનું લોજિક ---
  Future<void> _selectCheckIn() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // આજથી પહેલાની તારીખ નહીં
      lastDate: DateTime.now().add(const Duration(days: 60)), // ૨ મહિનાની મર્યાદા
    );
    if (picked != null) setState(() => checkIn = picked);
  }

  Future<void> _selectCheckOut() async {
    if (checkIn == null) return;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkIn!.add(const Duration(days: 1)),
      firstDate: checkIn!.add(const Duration(days: 1)),
      lastDate: checkIn!.add(const Duration(days: 2)), // ૨ દિવસની મર્યાદા
    );
    if (picked != null) setState(() => checkOut = picked);
  }
}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String mobile = ModalRoute.of(context)!.settings.arguments as String? ?? "9033291948";

    return Scaffold(
      appBar: AppBar(title: const Text("Reservation Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("FULL NAME"),
            const TextField(decoration: InputDecoration(hintText: "Enter your full name")),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("MOBILE NUMBER"),
                      const SizedBox(height: 10),
                      Text(mobile, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("NUMBER OF GUESTS"),
                      Row(
                        children: [
                          Text("$guestCount", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_drop_up, size: 30),
                                onPressed: guestCount < 3 ? () => _updateGuests(1) : null,
                              ),
                              if (guestCount > 1)
                                IconButton(
                                  icon: const Icon(Icons.arrow_drop_down, size: 30),
                                  onPressed: () => _updateGuests(-1),
                                ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Guest Aadhaar Details", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // ડાયનેમિક આધાર કાર્ડ ફિલ્ડ્સ
            ...List.generate(guestCount, (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: aadhaarControllers[index],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Guest ${index + 1} Aadhaar Number",
                  border: const OutlineInputBorder(),
                ),
              ),
            )),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CHECK-IN DATE"),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(checkIn == null ? "dd-mm-yyyy" : DateFormat('dd-MM-yyyy').format(checkIn!)),
                        trailing: const Icon(Icons.calendar_today_outlined),
                        onTap: _selectCheckIn,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CHECK-OUT DATE"),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(checkOut == null ? "dd-mm-yyyy" : DateFormat('dd-MM-yyyy').format(checkOut!)),
                        trailing: const Icon(Icons.calendar_today_outlined),
                        onTap: _selectCheckOut,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // રીવ્યુ પેજ આના પછી આવશે
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE67E22),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Review Booking", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectCheckIn() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // આજની પહેલાની તારીખ નહીં પસંદ થાય
      lastDate: DateTime.now().add(const Duration(days: 60)), // ૨ મહિના સુધીની મર્યાદા
    );
    if (picked != null) setState(() => checkIn = picked);
  }

  Future<void> _selectCheckOut() async {
    if (checkIn == null) return;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkIn!.add(const Duration(days: 1)),
      firstDate: checkIn!.add(const Duration(days: 1)),
      lastDate: checkIn!.add(const Duration(days: 2)), // ૨ દિવસની મર્યાદા
    );
    if (picked != null) setState(() => checkOut = picked);
  }
}
