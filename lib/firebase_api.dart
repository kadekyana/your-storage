import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _FirebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _FirebaseMessaging.requestPermission();

    final Token = await _FirebaseMessaging.getToken();

    print('Token $Token');
  }
}
