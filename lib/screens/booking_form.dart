import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  // --- વેરિયેબલ્સ સેટઅપ ---
  int guestCount = 1; 
  DateTime? checkIn;
  DateTime? checkOut;
  
  // ડાયનેમિક લિસ્ટ: જેટલા મહેમાન એટલા આધાર કાર્ડ કંટ્રોલર
  List<TextEditingController> aadhaarControllers = [TextEditingController()];
  final TextEditingController nameController = TextEditingController();

  // --- ગેસ્ટની સંખ્યા અપડેટ કરવાનું લોજિક ---
  void _updateGuests(int delta) {
    setState(() {
      int newCount = guestCount + delta;
      if (newCount >= 1 && newCount <= 3) {
        guestCount = newCount;
        if (delta > 0) {
          // નવો મહેમાન ઉમેરાય તો નવું ટેક્સ્ટ બોક્સ આપો
          aadhaarControllers.add(TextEditingController());
        } else {
          // મહેમાન ઓછો થાય તો છેલ્લું બોક્સ કાઢી નાખો
          aadhaarControllers.removeLast();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // હોમ પેજ પરથી આવતો મોબાઈલ નંબર (જો ના હોય તો ડિફોલ્ટ નંબર)
    final String mobile = ModalRoute.of(context)!.settings.arguments as String? ?? "9033291948";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation Details"),
        backgroundColor: const Color(0xFFE67E22),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ૧. નામ એન્ટ્રી
            const Text("FULL NAME", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            TextField(
              controller: nameController, 
              decoration: const InputDecoration(
                hintText: "Enter your full name",
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE67E22))),
              ),
            ),
            const SizedBox(height: 25),

            // ૨. મોબાઈલ અને ગેસ્ટ સિલેક્શન રો (Row)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("MOBILE NUMBER", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      Text(mobile, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("NUMBER OF GUESTS", style: TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          Text("$guestCount", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 15),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_drop_up, size: 35, color: Colors.green),
                                onPressed: guestCount < 3 ? () => _updateGuests(1) : null,
                              ),
                              if (guestCount > 1)
                                IconButton(
                                  icon: const Icon(Icons.arrow_drop_down, size: 35, color: Colors.red),
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
            const SizedBox(height: 25),

            // ૩. આધાર કાર્ડની વિગતો (જેટલા ગેસ્ટ હોય એટલા બોક્સ દેખાશે)
            const Text("Guest Aadhaar Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            ...List.generate(guestCount, (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: aadhaarControllers[index],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Guest ${index + 1} Aadhaar Number",
                  hintText: "12 digit number",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.credit_card),
                ),
              ),
            )),
            const SizedBox(height: 25),

            // ૪. તારીખ પસંદગી
            Row(
              children: [
                Expanded(
                  child: _datePickerColumn("CHECK-IN DATE", checkIn, _selectCheckIn),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _datePickerColumn("CHECK-OUT DATE", checkOut, _selectCheckOut),
                ),
              ],
            ),
            
            const SizedBox(height: 50),

            // ૫. રિવ્યુ બટન
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleReviewBooking, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE67E22),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Review Booking", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- હેલ્પર વિજેટ: તારીખના બોક્સ માટે ---
  Widget _datePickerColumn(String label, DateTime? date, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date == null ? "dd-mm-yyyy" : DateFormat('dd-MM-yyyy').format(date), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFFE67E22)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- તારીખ પસંદ કરવાનું લોજિક ---
  Future<void> _selectCheckIn() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked != null) setState(() => checkIn = picked);
  }

  Future<void> _selectCheckOut() async {
    if (checkIn == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("કૃપા કરીને પહેલા ચેક-ઈન તારીખ પસંદ કરો")));
      return;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkIn!.add(const Duration(days: 1)),
      firstDate: checkIn!.add(const Duration(days: 1)),
      lastDate: checkIn!.add(const Duration(days: 10)),
    );
    if (picked != null) setState(() => checkOut = picked);
  }

  // --- બટન દબાવતા શું થશે ---
  void _handleReviewBooking() {
    if (checkIn != null && checkOut != null && nameController.text.isNotEmpty) {
      Navigator.pushNamed(context, '/review', arguments: {
        'name': nameController.text,
        'mobile': "9033291948", // તમે જે નંબર સેટ કર્યો છે તે
        'guestCount': guestCount,
        'aadhaar': aadhaarControllers.map((c) => c.text).toList(),
        'checkIn': checkIn,
        'checkOut': checkOut,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("કૃપા કરીને બધી જ વિગતો ભરો"), backgroundColor: Colors.redAccent),
      );
    }
  }
}
