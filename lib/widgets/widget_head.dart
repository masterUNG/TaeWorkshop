import 'package:flutter/material.dart';
import 'package:taewhorkshop/utility/app_constant.dart';
import 'package:taewhorkshop/widgets/widget_image.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';

class WidgetHead extends StatelessWidget {
  const WidgetHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const WidgetImage(
          size: 60,
        ),
        WidgetText(
          data: 'Tae\nWorkshop',
          textStyle: AppConstant().h2Style(),
        ),
      ],
    );
  }
}