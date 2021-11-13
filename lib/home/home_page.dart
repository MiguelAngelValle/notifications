import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notifs_o2021/books.dart';
import 'package:push_notifs_o2021/main.dart';
import 'package:push_notifs_o2021/utils/notification_util.dart';
import 'notif_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications()
        .requestPermissionToSendNotifications()
        .then((isAllowed) {
      if (isAllowed) {
        AwesomeNotifications().displayedStream.listen((notificationMsg) {
          print(notificationMsg);
        });
      }
    });
    AwesomeNotifications().actionStream.listen((notificationAction) {
      if (!StringUtils.isNullOrEmpty(notificationAction.buttonKeyInput)) {
        print(notificationAction);
      } else {
        print(notificationAction);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void processDefaultActionRecived(ReceivedAction action) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Books(
              datos: action.title,
            )));
  }

  void showNotification() {
    setState(() {});
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: CircleAvatar(
              maxRadius: 120,
              backgroundColor: Colors.black87,
              child: Image.asset(
                "assets/books.png",
                height: 120,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: NotifMenu(
              notifSimple: () => showBasicNotification(123),
              notifConIcono: () => showLargeIconNotification(123),
              notifConImagen: () => showBigPictureIconNotification(123),
              notifConAccion: () => showBigPictureAndActionButtonsAndReply(123),
              notifAgendada: () => repeatNotification(123),
              cancelNotifAgendada: () => {},
            ),
          ),
        ],
      ),
    );
  }
}
