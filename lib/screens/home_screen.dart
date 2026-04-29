import 'package:flutter/material.dart';
import 'dart:ui'; // બ્લર ઇફેક્ટ માટે જરૂરી

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // લોગિન સ્ક્રીન પરથી આવતો મોબાઈલ નંબર અહીં મળશે
    final String mobile = ModalRoute.of(context)!.settings.arguments as String? ?? "9033291948";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("NATHDWARA HOTEL", 
          style: TextStyle(color: Color(0xFF8B4513), fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: Text("Guest: $mobile", style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {}, // નોટિફિકેશન પેજ પછી જોડીશું
          ),
          Builder(builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          )),
        ],
      ),
      // જમણી બાજુથી ખુલતું મેનુ (Drawer)
      endDrawer: _buildBlurDrawer(context),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("WELCOME TO", 
                style: TextStyle(color: Colors.orange, letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 10),
              const Text("A Divine Stay in Nathdwara", 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2)),
              const SizedBox(height: 20),
              const Text("Experience comfort, tranquility, and warm hospitality just steps away from the sacred Shrinathji Temple.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/booking', arguments: mobile),
                      icon: const Icon(Icons.calendar_today, size: 16),
                      label: const Text("Book a Room"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE67E22),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.list_alt, size: 16),
                      label: const Text("View My Summary"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // બ્લર મેનુ બનાવવાનું ફંક્શન (Photo 9)
  Widget _buildBlurDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // પાછળનું બ્લર કરવા માટે
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.white.withOpacity(0.7)),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ),
                const ListTile(title: Text("Menu", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                ListTile(leading: const Icon(Icons.home_outlined), title: const Text("Home"), onTap: () => Navigator.pop(context)),
                ListTile(leading: const Icon(Icons.list_alt), title: const Text("My Summary"), onTap: () {}),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone_in_talk_outlined, color: Colors.orange, size: 20),
                          SizedBox(width: 10),
                          Text("Vaishnav Support", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("Mobile: 87996 51611", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("Call Timings:\n9:00 a.m. to 1:00 p.m.\n5:00 p.m. to 9:00 p.m.", 
                        style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.5)),
                    ],
                  ),
                ),
                ListTile(leading: const Icon(Icons.feedback_outlined), title: const Text("Send Feedback"), onTap: () {}),
                const Spacer(),
                const ListTile(leading: Icon(Icons.logout, color: Colors.red), title: Text("Log Out", style: TextStyle(color: Colors.red))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
