// @dart=2.9
import 'dart:async';

import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/firebase_options.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_bloc_state.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_provider_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/event/event_message_view.dart';
import 'package:babi_cakes_mobile/src/features/core/service/event/providers_service.dart';
import 'package:babi_cakes_mobile/src/features/core/service/notification/firebase_messaging_service.dart';
import 'package:babi_cakes_mobile/src/features/core/service/notification/notification_service.dart';
import 'package:babi_cakes_mobile/src/utils/theme/theme.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';



@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('Handling a background message: ${message.data}');
  if(message.data.isNotEmpty) {
    getIt<EventBus>().fire(EventMessageView.fromJson(message.data));
  }
}

main() {
  Config.buildMode = Modo.production;

  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen(firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  setupProviders();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ShoppingCartController(),
          ),
          ChangeNotifierProvider(
            create: (context) => BudgetProviderController(),
          ),
          Provider<NotificationService>(create: (context) => NotificationService(),),
          Provider<FirebaseMessagingService>(create: (context) => FirebaseMessagingService(context.read<NotificationService>()),),
          bloc.BlocProvider<BudgetBlocState>(create: (context) => BudgetBlocState(),)
        ],
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
    debugPrint('Permissão concedida pelo usuário ${settings.authorizationStatus}');
  } else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('Permissão concedida provisoriamente pelo usuário ${settings.authorizationStatus}');
  } else {
    debugPrint('Permissão negada pelo usuário');
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

