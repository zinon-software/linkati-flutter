import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:linkati/firebase_options.dart';

import 'new_code/screens/home_screen.dart';

// SharedPreferences? prefs;
String? urlServer, bannarIsAd, interstIsAd, nativeIsAd;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // prefs = await SharedPreferences.getInstance();
  // print(prefs?.getString('token'));
  // print(prefs?.getInt('user_id'));

  // GlobalBindings().dependencies();

  // MobileAds.instance.initialize();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              details.exception.toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AE"),
      home: HomeScreen(),
    );

    // const GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    // themeMode: ThemeMode.dark,
    // localizationsDelegates: [
    //   GlobalCupertinoLocalizations.delegate,
    //   GlobalMaterialLocalizations.delegate,
    //   GlobalWidgetsLocalizations.delegate,
    // ],
    // supportedLocales: [Locale("ar", "AE")],
    // locale: Locale("ar", "AE"),
    // home: SplashView(),
    // );
  }
}

// class GlobalBindings extends Bindings {
//   @override
//   void dependencies() {
//     // ignore: unused_local_variable
//     Get.put(PostController(), permanent: true);
//     // ignore: unused_local_variable
//     Get.put(UsersController());
//     // ignore: unused_local_variable
//     Get.lazyPut(() => FromPostController(), fenix: true);
//     // ignore: unused_local_variable
//     Get.lazyPut(() => NotificationController(), fenix: true);
//     // ignore: unused_local_variable
//     Get.lazyPut(() => LikeController(), fenix: true);
//   }
// }
