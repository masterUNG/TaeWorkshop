// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:taewhorkshop/utility/app_constant.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';

class WidgetMenu extends StatelessWidget {
  const WidgetMenu({
    Key? key,
    required this.title,
    this.leadWidget,
    this.subTitleWidget,
    this.pressFunc,
  }) : super(key: key);

  final String title;
  final Widget? leadWidget;
  final Widget? subTitleWidget;
  final Function()? pressFunc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadWidget,
      title: WidgetText(data: title, textStyle: AppConstant().h2Style(),),
      subtitle: subTitleWidget,
      onTap: pressFunc,
    );
  }
}
