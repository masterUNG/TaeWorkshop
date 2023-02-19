// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    required this.hint,
    required this.changeFunc,
    this.obsecu,
  }) : super(key: key);

  final String hint;
  final Function(String) changeFunc;
  final bool? obsecu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250, height: 40,
      child: TextFormField(
        obscureText: obsecu ?? false,
        onChanged: changeFunc,
        decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          hintText: hint,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
