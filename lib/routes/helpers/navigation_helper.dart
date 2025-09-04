import 'package:flutter/material.dart';

class NavigationHelper {
  static void safePush(BuildContext context, Widget page) {
    final String targetRouteName = page.runtimeType.toString();

    bool alreadyInStack = false;

    Navigator.popUntil(context, (route) {
      // Check all routes, do NOT stop early
      if (route.settings.name == targetRouteName) {
        alreadyInStack = true;
      }
      return true; // keep going until we reach bottom
    });

    if (!alreadyInStack) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
          settings: RouteSettings(name: targetRouteName),
        ),
      );
    }
  }
}
