import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taewhorkshop/bodys/body_about_me.dart';
import 'package:taewhorkshop/bodys/body_user.dart';
import 'package:taewhorkshop/utility/app_constant.dart';
import 'package:taewhorkshop/utility/app_controller.dart';
import 'package:taewhorkshop/widgets/widget_image.dart';
import 'package:taewhorkshop/widgets/widget_menu.dart';
import 'package:taewhorkshop/widgets/widget_sign_out.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';

class MainHomeUser extends StatefulWidget {
  const MainHomeUser({super.key});

  @override
  State<MainHomeUser> createState() => _MainHomeUserState();
}

class _MainHomeUserState extends State<MainHomeUser> {
  var titles = <String>[
    'Main Home',
    'Aboue Me',
  ];
  var bodys = <Widget>[
    const BodyUser(),
    const BodyAboutMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('userModel --> ${appController.userModels.length}');
          return Scaffold(
            appBar: AppBar(
              title: WidgetText(
                data: titles[appController.indexDrawer.value],
                textStyle: AppConstant().h2Style(),
              ),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: appController.userModels.isEmpty
                        ? const SizedBox()
                        : WidgetText(
                            data: appController.userModels.last.name,
                            textStyle:
                                AppConstant().h2Style(color: Colors.white),
                          ),
                    accountEmail: appController.userModels.isEmpty
                        ? const SizedBox()
                        : WidgetText(
                            data: appController.userModels.last.email,
                            textStyle:
                                AppConstant().h3Style(color: Colors.white),
                          ),
                    currentAccountPicture: const WidgetImage(),
                  ),
                  WidgetMenu(
                    title: 'Main Home',
                    leadWidget: const Icon(
                      Icons.home_outlined,
                      size: 36,
                    ),
                    pressFunc: () {
                      appController.indexDrawer.value = 0;
                      Get.back();
                    },
                  ),
                  WidgetMenu(
                    title: 'About Me',
                    leadWidget: const Icon(
                      Icons.person_2_outlined,
                      size: 36,
                    ),
                    pressFunc: () {
                      appController.indexDrawer.value = 1;
                      Get.back();
                    },
                  ),
                  const Spacer(),
                  const Divider(),
                  const WidgetSignOut()
                ],
              ),
            ),
            body: bodys[appController.indexDrawer.value],
          );
        });
  }
}
