import 'package:flutter/material.dart';

import '../resources/colors.dart';

class CheckboxApp extends StatefulWidget {
  final Function(bool) onChanged;

  const CheckboxApp({super.key, required this.onChanged});

  @override
  _CheckboxApp createState() => _CheckboxApp();
}

class _CheckboxApp extends State<CheckboxApp> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
              widget.onChanged(isChecked);
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
