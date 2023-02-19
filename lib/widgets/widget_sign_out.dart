import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taewhorkshop/utility/app_dialog.dart';
import 'package:taewhorkshop/widgets/widget_image.dart';
import 'package:taewhorkshop/widgets/widget_menu.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';
import 'package:taewhorkshop/widgets/widget_text_button.dart';

class WidgetSignOut extends StatelessWidget {
  const WidgetSignOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetMenu(
      title: 'Sign Out',
      leadWidget: const WidgetImage(
        path: 'images/exit.png',
      ),
      subTitleWidget: const WidgetText(data: 'Sign Out & New Authen'),
      pressFunc: () {
        Get.back();
        AppDialog(context: context).normalDialot(
            title: 'Confirm SignOut ?',
            detail: 'Please Confirm SignOut',
            iconWidget: const WidgetImage(
              path: 'images/exit.png',
              size: 100,
            ),
            action2Widget: WidgetTextButton(
              label: 'Sign Out',
              pressFunc: () async {
                await FirebaseAuth.instance
                    .signOut()
                    .then((value) => Get.offAllNamed('/authen'));
              },
            ));
      },
    );
  }
}
