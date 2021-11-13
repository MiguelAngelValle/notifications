import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:push_notifs_o2021/utils/constants_utils.dart';

/// Notificacion basica solo texto
/// El channel debe ser igual al de la inicializacion
Future<void> showBasicNotification(int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: channelSimpleId,
      title: simpleTitle,
      body: simpleDescr,
    ),
  );
}

/// Notificacion basica con icono a la derecha
/// payload es datos que pudieramos utilizar para algo
/// El channel debe ser igual al de la inicializacion
Future<void> showLargeIconNotification(int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: channelBigPictureId,
      title: bigPictureTitle,
      body: bigPictureDescr,
      largeIcon: iconExample,
      notificationLayout: NotificationLayout.BigPicture,
      payload: {'uuid': 'uuid-test'},
    ),
  );
}

Future<void> showBigPictureIconNotification(int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: channelBigPictureId,
      title: bigPictureTitle,
      body: bigPictureDescr,
      largeIcon: iconExample,
      bigPicture: pictureExample,
      notificationLayout: NotificationLayout.BigPicture,
      payload: {'uuid': 'uuid-test'},
    ),
  );
}

Future<void> repeatNotification(int id) async {
  String localTime = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelScheduleId,
        title: scheduledTitle,
        body: scheduledDescr,
      ),
      schedule: NotificationInterval(
          interval: 60, timeZone: localTime, repeats: true));
}

Future<void> showBigPictureAndActionButtonsAndReply(int id) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelBigPictureId,
        title: bigPictureTitle,
        body: bigPictureDescr,
        largeIcon: iconExample,
        notificationLayout: NotificationLayout.BigPicture,
        payload: {'uuid': 'uuid-test'},
      ),
      actionButtons: [
        NotificationActionButton(
            key: actionOneKey,
            label: actionOneTitle,
            buttonType: ActionButtonType.InputField),
        NotificationActionButton(
            key: actionTwoKey,
            label: actionTwoTitle,
            buttonType: ActionButtonType.Default),
      ]);
}
