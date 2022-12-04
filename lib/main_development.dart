// @dart=2.9
import 'dart:async';

import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/firebase_options.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.data}');
}

Future<void> main() async {
  Config.buildMode = Modo.development;
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onMessage.listen(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ShoppingCartController(),
      child: MyApp(),
    )
  );
}

Future<void> notificationSettingAuthorized() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    sound: true
  );

  if(settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Permissão concedida pelo usuário ${settings.authorizationStatus}');
  } else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('Permissão concedida provisoriamente pelo usuário ${settings.authorizationStatus}');
  } else {
    print('Permissão negada pelo usuário');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const SplashScreen(),
    );
  }
}
