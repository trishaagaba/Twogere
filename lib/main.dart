import 'package:flutter/material.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:twongere/route.dart';
import 'package:twongere/routes/camera_sample/test_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async'; // For StreamSubscription
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

List<CameraDescription> cameras = [];
Future<void> main()async {
   try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Your app icon

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
   // await Firebase.initializeApp();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twongere',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 3, 51, 102)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesGenerator.splashScreen,
      onGenerateRoute: RoutesGenerator.generateRoute,
      // home: const SettingsScreen() //CameraExampleHome(),
    );
  }
}


