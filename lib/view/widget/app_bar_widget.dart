import 'package:flutter/material.dart';

AppBar buildAppBarWithoutColor(BuildContext context) {
  return AppBar(
    leading: const BackButton(
      color: Colors.black,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}

AppBar buildAppBar(BuildContext context, String text) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(text),
    centerTitle: true,
  );
}
