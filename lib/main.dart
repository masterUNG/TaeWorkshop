import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taewhorkshop/models/user_model.dart';
import 'package:taewhorkshop/states/authen.dart';
import 'package:taewhorkshop/states/main_home_shopper.dart';
import 'package:taewhorkshop/states/main_home_user.dart';
import 'package:taewhorkshop/utility/app_service.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/User',
    page: () => const MainHomeUser(),
  ),
  GetPage(
    name: '/Shopper',
    page: () => const MainHomeShopper(),
  ),
];

String firstPage = '/authen';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event == null) {
        runApp(MyApp());
      } else {
        String uidLogin = event.uid;
        UserModle? userModle =
            await AppService().findUserModel(uidLogin: uidLogin);
        firstPage = '/${userModle!.typeUser}';
        runApp(const MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,
      initialRoute: firstPage,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
