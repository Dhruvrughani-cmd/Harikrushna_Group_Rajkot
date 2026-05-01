import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveBooking(BookingModel booking) async {
    try {
      await _db.collection('bookings').add(booking.toMap());
    } catch (e) {
      print("Error: $e");
    }
  }
}
