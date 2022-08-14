import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  final Function()? onPressed;
  const AlertWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          size: 110,
          color: Colors.amber,
        ),
        const Text(
          "Oops, Something Wrong",
          style: TextStyle(fontSize: 22),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text("REFRESH"),
        )
      ],
    );
  }
}
