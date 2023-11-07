import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:your_storage/app/modules/CheckGlobalNetwork/views/check_global_network_view.dart';
import 'package:your_storage/app/modules/splashScreen/views/splash_screen_view.dart';
import 'package:your_storage/firebase_api.dart';
import 'package:your_storage/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  final CameraPermission = await Permission.camera.request();
  if (CameraPermission.isGranted) {
    runApp(
      const MyApp(),
    );
    CheckGlobalNetwork.init();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(),
    );
  }
}
