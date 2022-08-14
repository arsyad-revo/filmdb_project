import 'package:flutter/material.dart';

showSnackbar(context, text, {Color? color}) {
  var snackBar = SnackBar(
    content: Text('$text'),
    backgroundColor: color,
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

customLoading() {
  return CircularProgressIndicator(
    color: Colors.green[300],
  );
}
