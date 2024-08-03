import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/styles.dart';

class CounterWidget extends StatefulWidget {
  final int initialQuantity;

  CounterWidget({required this.initialQuantity});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialQuantity; // Set initial value
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 25,
          height: 25,
          child: ElevatedButton(
            onPressed: _decrementCounter,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.zero, // Remove internal padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Icon(
              Icons.remove,
              color: primaryColor,
              size: 15, // Adjust the icon size
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '$_counter',
            style: Styles.title,
          ),
        ),
        SizedBox(
          width: 25,
          height: 25,
          child: ElevatedButton(
            onPressed: _incrementCounter,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.zero, // Remove internal padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 15, // Adjust the icon size
            ),
          ),
        ),
      ],
    );
  }
}
