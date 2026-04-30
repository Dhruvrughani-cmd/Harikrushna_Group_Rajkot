class HolidayData {
  // વર્ષ ૨૦૨૬ ના તમામ ધર્મોના મુખ્ય તહેવારો અને જાહેર રજાઓનું લિસ્ટ
  static Map<DateTime, String> holidays = {
    // January
    DateTime(2026, 1, 1): "New Year's Day",
    DateTime(2026, 1, 14): "Uttarayan / Makar Sankranti",
    DateTime(2026, 1, 15): "Vasi Uttarayan",
    DateTime(2026, 1, 26): "Republic Day",

    // February
    DateTime(2026, 2, 15): "Maha Shivratri",

    // March
    DateTime(2026, 3, 3): "Holi",
    DateTime(2026, 3, 4): "Dhuleti",
    DateTime(2026, 3, 20): "Eid-ul-Fitr (Ramzan Eid)*", // ચંદ્ર મુજબ ફેરફાર થઈ શકે
    DateTime(2026, 3, 29): "Ram Navami",

    // April
    DateTime(2026, 4, 1): "Mahavir Jayanti",
    DateTime(2026, 4, 2): "Hanuman Jayanti",
    DateTime(2026, 4, 5): "Good Friday",
    DateTime(2026, 4, 14): "Ambedkar Jayanti",

    // May
    DateTime(2026, 5, 1): "Gujarat Day / Labour Day",
    DateTime(2026, 5, 27): "Eid-ul-Adha (Bakri Eid)*",

    // June & July
    DateTime(2026, 6, 26): "Ashadhi Bij (Rath Yatra)",
    DateTime(2026, 7, 26): "Muharram*",
    DateTime(2026, 7, 16): "Dhruv Birthday",

    // August
    DateTime(2026, 8, 15): "Independence Day",
    DateTime(2026, 8, 26): "Raksha Bandhan",
    DateTime(2026, 8, 28): "Samvatsari (Jain)",
    DateTime(2026, 9, 3): "Janmashtami",

    // September
    DateTime(2026, 9, 16): "Ganesh Chaturthi",
    DateTime(2026, 9, 25): "Eid-e-Milad*",

    // October
    DateTime(2026, 10, 2): "Gandhi Jayanti",
    DateTime(2026, 10, 20): "Dusshera",

    // November
    DateTime(2026, 11, 7): "Kali Chaudas",
    DateTime(2026, 11, 8): "Diwali",
    DateTime(2026, 11, 9): "Gujarati New Year (Bestu Varas)",
    DateTime(2026, 11, 10): "Bhai Dooj",
    DateTime(2026, 11, 13): "Labh Pancham",
    DateTime(2026, 11, 15): "Jalaram Jayanti",
    DateTime(2026, 11, 24): "Guru Nanak Jayanti",

    // December
    DateTime(2026, 12, 25): "Christmas",
  };

  // ચેક કરવા માટેનું ફંક્શન
  static String? getHoliday(DateTime day) {
    DateTime dateOnly = DateTime(day.year, day.month, day.day);
    return holidays[dateOnly];
  }
}
