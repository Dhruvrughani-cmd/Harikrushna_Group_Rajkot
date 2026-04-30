import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart'; // આ માટે pubspec માં table_calendar ઉમેરવું પડશે

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> adminNumbers = ['94097773955', '8799651611'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  // રિજેક્ટ કરવાનું ફંક્શન (રીઝન સાથે)
  void _rejectBooking(String docId) {
    TextEditingController reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reject Request"),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(hintText: "Enter reason for rejection"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('bookings').doc(docId).update({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "PENDING"),
            Tab(text: "CONFIRMED"),
            Tab(text: "REJECTED"),
            Tab(text: "CALENDAR VIEW"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList('PENDING'),
          _buildBookingList('CONFIRMED'),
          _buildBookingList('REJECTED'),
          const AdminCalendarView(),
        ],
      ),
    );
  }

  // બુકિંગ લિસ્ટ બિલ્ડર
  Widget _buildBookingList(String status) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('status', isEqualTo: status)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        var docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var data = docs[index].data();
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(data['full_name'] ?? "No Name"),
                subtitle: Text("Status: ${data['status']}"),
                trailing: status == 'PENDING' ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => FirebaseFirestore.instance
                          .collection('bookings')
                          .doc(docs[index].id)
                          .update({'status': 'CONFIRMED'}),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _rejectBooking(docs[index].id),
                    ),
                  ],
                ) : null,
              ),
            );
          },
        );
      },
    );
  }
}

// કેલેન્ડર વ્યુ માટે અલગ ક્લાસ
class AdminCalendarView extends StatelessWidget {
  const AdminCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2026, 1, 1),
      lastDay: DateTime.utc(2026, 12, 31),
      focusedDay: DateTime.now(),
      // અહીં આપણે ઇવેન્ટ્સ અને હોલીડેઝ લોડ કરી શકીએ
    );
  }
}
