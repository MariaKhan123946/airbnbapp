import 'package:flutter/material.dart';

class AmenitiesUi extends StatefulWidget {
  final String type;
  final int startValue;
  final Function decreaseValue;
  final Function increaseValue;

  AmenitiesUi({
    Key? key,
    required this.type,
    required this.decreaseValue,
    required this.increaseValue,
    required this.startValue,
  }) : super(key: key);

  @override
  State<AmenitiesUi> createState() => _AmenitiesUiState();
}

class _AmenitiesUiState extends State<AmenitiesUi> {
  late int _valueDigit;

  @override
  void initState() {
    super.initState();
    _valueDigit = widget.startValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.type,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                if (_valueDigit > 0) {
                  setState(() {
                    widget.decreaseValue();
                    _valueDigit--;
                  });
                }
              },
              icon: const Icon(Icons.remove),
            ),
            Text(
              '$_valueDigit',
              style: const TextStyle(fontSize: 18.0),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.increaseValue();
                  _valueDigit++;
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
