import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../view/fcmpage.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    /// initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@drawable/ic_launcher"),
    );
    FirebaseMessaging message = FirebaseMessaging.instance;
    await message.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    await message.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? id) async {
        print("onSelectNotification");

        print("Router Value1234 $id");
        Get.to(() => FcmPage(
              player: player,
              title: title,
              body: body,
              date: currentDate,
            ));
        /*   Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DemoScreen(
                id: id,
              ),
            ),
          );*/
      },
    );
  }

  static void createanddisplaynotification(
    RemoteMessage message,
  ) async {
    // const int insistentFlag = 4;
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          "fcmpushnotification",
          "fcmpushnotificationchannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: false,

          /*  sound: RawResourceAndroidNotificationSound('music'),
          additionalFlags: Int32List.fromList(<int>[insistentFlag]),*/
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data[id],
        // payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
