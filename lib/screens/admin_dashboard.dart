import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/holiday_data.dart'; // રજાઓના લિસ્ટ માટે

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VRAJNIVAS ADMIN", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFE67E22),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "PENDING"),
            Tab(text: "CONFIRMED"),
            Tab(text: "REJECTED"),
            Tab(text: "CALENDAR"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList('PENDING'),
          _buildBookingList('CONFIRMED'),
          _buildBookingList('REJECTED'),
          const AdminCalendarTab(), // કેલેન્ડર પેજ
        ],
      ),
    );
  }

  // બુકિંગ લિસ્ટ બતાવવા માટેનું ફંક્શન
  Widget _buildBookingList(String status) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('status', isEqualTo: status)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        var docs = snapshot.data!.docs;
        
        if (docs.isEmpty) return const Center(child: Text("No records found"));

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var data = docs[index].data();
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: ListTile(
                title: Text(data['full_name'] ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("ID: ${docs[index].id.substring(0, 8)} | Guest: ${data['total_guests']}"),
                trailing: status == 'PENDING' ? _buildActionButtons(docs[index].id) : null,
              ),
            );
          },
        );
      },
    );
  }

  // Approve/Reject બટન્સ
  Widget _buildActionButtons(String docId) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.check_circle, color: Colors.green),
          onPressed: () => FirebaseFirestore.instance.collection('bookings').doc(docId).update({'status': 'CONFIRMED'}),
        ),
        IconButton(
          icon: const Icon(Icons.cancel, color: Colors.red),
          onPressed: () => _showRejectDialog(docId),
        ),
      ],
    );
  }

  // રિજેક્ટ કરવાનું ડાયલોગ બોક્સ
  void _showRejectDialog(String docId) {
    TextEditingController reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reason for Rejection"),
        content: TextField(controller: reasonController, decoration: const InputDecoration(hintText: "Enter reason")),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('bookings').doc(docId).update({
                'status': 'REJECTED',
                'rejection_reason': reasonController.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Reject"),
          ),
        ],
      ),
    );
  }
}

// ખાસ કેલેન્ડર વ્યુ માટેનો ક્લાસ
class AdminCalendarTab extends StatelessWidget {
  const AdminCalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('bookings').where('status', isEqualTo: 'CONFIRMED').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        // કન્ફર્મ થયેલી તારીખોનું લિસ્ટ બનાવો
        List<DateTime> confirmedDates = snapshot.data!.docs.map((doc) {
          return (doc['check_in'] as Timestamp).toDate();
        }).toList();

        return TableCalendar(
          firstDay: DateTime.utc(2026, 1, 1),
          lastDay: DateTime.utc(2026, 12, 31),
          focusedDay: DateTime.now(),
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
          ),
          // રજાઓ અને બુકિંગ માટેની સ્પેશિયલ ડિઝાઇન
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              // ૧. ચેક કરો કે આ દિવસે કોઈ રજા છે?
              String? holiday = HolidayData.getHoliday(day);
              if (holiday != null) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle),
                  child: Text(day.day.toString(), style: const TextStyle(color: Colors.black)),
                );
              }

              // ૨. ચેક કરો કે આ દિવસે કોઈ બુકિંગ કન્ફર્મ છે? (Green Color)
              for (var date in confirmedDates) {
                if (isSameDay(date, day)) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                    child: Text(day.day.toString(), style: const TextStyle(color: Colors.white)),
                  );
                }
              }
              return null;
            },
          ),
        );
      },
    );
  }
}
