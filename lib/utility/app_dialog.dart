// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taewhorkshop/utility/app_constant.dart';
import 'package:taewhorkshop/widgets/widget_image.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';
import 'package:taewhorkshop/widgets/widget_text_button.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialot({
    required String title,
    required String detail,
    Widget? actionWidget,
    Widget? iconWidget,
    Widget? action2Widget,
  }) {
    Get.dialog(
      AlertDialog(
        icon: iconWidget ?? const WidgetImage(
          size: 100,
        ),
        title: WidgetText(
          data: title,
          textStyle: AppConstant().h2Style(),
        ),
        content: WidgetText(data: detail),
        actions: [action2Widget ?? const SizedBox(),
          actionWidget ??
              WidgetTextButton(
                label: 'Cancel',
                pressFunc: () {
                  Get.back();
                },
              )
        ],
      ),
      barrierDismissible: false,
    );
  }
}
