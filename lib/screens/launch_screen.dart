import 'package:flutter/material.dart';
import 'package:polling_app/constants.dart';
import 'package:polling_app/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';
import 'package:polling_app/states/authentication.dart';
import 'package:polling_app/utilities.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gotoHomeScreen(context);

    return Consumer<AuthenticationState>(
      builder: (builder, authState, child) {
        return Container(
          width: 400,
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Text(
                  AppName,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              if (authState.authStatus == kAuthLoading)
                Text(
                  'loading...',
                  style: TextStyle(fontSize: 12.0),
                ),
              if (authState.authStatus == null ||
                  authState.authStatus == kAuthError)
                Container(
                  child: Column(
                    children: <Widget>[
                      LoginButton(
                        label: 'Sign In with Google',
                        onPressed: () => signIn(context, kAuthSignInGoogle),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      LoginButton(
                        label: 'Sign In Anonymously',
                        onPressed: () => signIn(context, kAuthSignInAnonymous),
                      ),
                    ],
                  ),
                ),
              if (authState.authStatus == kAuthError)
                Text(
                  'Error...',
                  style: TextStyle(fontSize: 12.0, color: Colors.redAccent),
                ),
            ],
          ),
        );
      },
    );
  }

  void signIn(context, String service) {
    Navigator.pushReplacementNamed(context, '/main menu');
    Provider.of<AuthenticationState>(context, listen: false)
        .login(serviceName: service);
  }
}
