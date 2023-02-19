import 'package:flutter/material.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';

class MainHomeShopper extends StatelessWidget {
  const MainHomeShopper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: WidgetText(data: 'This is Shopper'),),);
  }
}