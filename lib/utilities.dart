import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:polling_app/states/authentication.dart";

void gotoHomeScreen(BuildContext context) {
  Future.microtask(() {
    if (Provider.of<AuthenticationState>(context, listen: false).authStatus ==
        kAuthSuccess) {
      Navigator.pushReplacementNamed(context, '/main menu');
    }
  });
}

void gotoLoginScreen(BuildContext context) {
  Future.microtask(() {
    if (Provider.of<AuthenticationState>(context, listen: false).authStatus ==
        null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  });
}