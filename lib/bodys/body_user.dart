import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taewhorkshop/bodys/body_list_shop.dart';
import 'package:taewhorkshop/bodys/body_map.dart';
import 'package:taewhorkshop/utility/app_controller.dart';
import 'package:taewhorkshop/utility/app_service.dart';

class BodyUser extends StatefulWidget {
  const BodyUser({super.key});

  @override
  State<BodyUser> createState() => _BodyUserState();
}

class _BodyUserState extends State<BodyUser> {
  var titles = <String>[
    'Map',
    'List Shop',
  ];
  var iconDatas = <IconData>[
    Icons.map_outlined,
    Icons.list,
  ];
  var bottonNavigationBarItems = <BottomNavigationBarItem>[];

  var bodys = <Widget>[
    const BodyMap(),
    const BodyListShop(),
  ];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < titles.length; i++) {
      bottonNavigationBarItems.add(
        BottomNavigationBarItem(
          icon: Icon(iconDatas[i]),
          label: titles[i],
        ),
      );
    }

    AppService().readAllShop();
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('indexBottom --> ${appController.indexBottom}');
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: bottonNavigationBarItems,
              currentIndex: appController.indexBottom.value,
              onTap: (value) {
                appController.indexBottom.value = value;
              },
            ),
            body: bodys[appController.indexBottom.value],
          );
        });
  }
}
