class BookingModel {
  String name;
  String mobile;
  int guestCount;
  List<String> aadhaarList;

  BookingModel({
    required this.name,
    required this.mobile,
    required this.guestCount,
    required this.aadhaarList,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobile': mobile,
      'guestCount': guestCount,
      'aadhaarList': aadhaarList,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
