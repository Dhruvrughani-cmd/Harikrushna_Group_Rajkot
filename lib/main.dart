import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/booking_form.dart';
import 'screens/review_details_screen.dart';
import 'screens/summary_screen.dart';
import 'screens/admin_dashboard.dart';
import 'services/notification_service.dart';
void main() async {
  // ફ્લટર એન્જિન તૈયાર કરો
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // ૧. ફાયરબેઝ લોડ કરો (સુરક્ષિત રીતે)
  try {
    await Firebase.initializeApp(); 
    debugPrint("Firebase successfully connected!");
  } catch (e) {
    debugPrint("Firebase connection failed: $e");
  }

  // ૨. પરમિશન લોડ કરો
  try {
    await NotificationService.requestNotificationPermission();
  } catch (e) {
    debugPrint("Permission error: $e");
  }

  // ૩. એપ શરૂ કરો
  runApp(const HarikrushnaApp());
}
class HarikrushnaApp extends StatelessWidget {
  const HarikrushnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harikrushna Group Rajkot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFEFDF8), 
        primaryColor: const Color(0xFFE67E22), 
        textTheme: GoogleFonts.loraTextTheme(), 
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/admin': (context) => const AdminDashboard(),
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/booking': (context) => const BookingForm(),
      '/review': (context) => const ReviewDetailsScreen(),
      '/summary': (context) => const SummaryScreen(),
      },
    );
  }
}
