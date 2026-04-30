import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  // એપ શરૂ થાય ત્યારે નોટિફિકેશન પરમિશન માંગવા માટેનું ફંક્શન
  static Future<void> requestNotificationPermission() async {
    // નોટિફિકેશન સ્ટેટસ ચેક કરો
    var status = await Permission.notification.status;
    
    if (status.isDenied) {
      // જો પરમિશન ન આપી હોય તો પોપ-અપ બતાવો
      await Permission.notification.request();
    }
  }
}
