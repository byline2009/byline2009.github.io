import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Function onPressed;

  const CustomButton(
      {Key? key,
      this.width = 220,
      this.height = 40,
      required this.child,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          child: child,
        ));
  }
}
