import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/controllers/Notification_controller.dart';
import 'src/controllers/form_post_controller.dart';
import 'src/controllers/like_controller.dart';
import 'src/controllers/post_controller.dart';
import 'src/controllers/users_controller.dart';
import 'src/views/splash/splash_view.dart';

SharedPreferences? prefs;
String? urlServer, bannarIsAd, interstIsAd, nativeIsAd;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  print(prefs?.getString('token'));
  print(prefs?.getInt('user_id'));
  
  GlobalBindings().dependencies();

  MobileAds.instance.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AE"),
      home: SplashView(),
    );
  }
}

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // ignore: unused_local_variable
    final PostController postController = Get.put(PostController(), permanent: true);
    // ignore: unused_local_variable
    final UsersController usersControllerController = Get.put(UsersController());
    // ignore: unused_local_variable
    final fromPostController = Get.lazyPut(() => FromPostController(), fenix: true);
    // ignore: unused_local_variable
    final notifyController = Get.lazyPut(() => NotificationController(), fenix: true);
    // ignore: unused_local_variable
    final likeController = Get.lazyPut(() => LikeController(), fenix: true);
  }
}
