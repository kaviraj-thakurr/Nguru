import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nguru/main.dart';
import 'package:nguru/screens/notification_screen.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';


Future<void> handleBackgroundMessaging(RemoteMessage message) async {
   log("unique device title: ${message.notification?.title}");
    log("unique device body: ${message.notification?.body}");
     log("unique device payload: ${message.data}");
}
class FirebaseApi{
  final _firebaseMessaging= FirebaseMessaging.instance;


  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: "This channel used for important notification",
    importance: Importance.defaultImportance,
    );

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log("unique device token: $fCMToken");
    await SharedPref.saveFcmToken(fCMToken ?? "");
   // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);
   initPushNotifications();
   initLocalnotifications();
  }


final _localNotificaions=FlutterLocalNotificationsPlugin();





// routs
  void handleMessage(RemoteMessage? message){
    if(message == null){
      return;
    }

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }


// for IOS
  Future initPushNotifications() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);
    FirebaseMessaging.onMessage.listen((message) {
      final notification= message.notification;
      if(notification==null) return;

      _localNotificaions.show(
        notification.hashCode, 
        notification.title, 
        notification.body, 
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id, 
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/ic_launcher")
        ),
        payload: jsonEncode(message.toMap()),
        );
        
    });
  }



  // local notification (if device is not connected to the internet)
  Future initLocalnotifications() async{
   // const iOS= IOSInitializationSetting>>s();
    const android= AndroidInitializationSettings("@drawable/ic_launcher");
    const settings= InitializationSettings(android: android,);

  }
}