import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polling_app/constants.dart';
import 'package:polling_app/screens/launch_screen.dart';
import 'package:polling_app/screens/selection_screen.dart';
import 'package:polling_app/screens/ballet_results.dart';
import 'package:polling_app/states/ballot.dart';
import 'package:polling_app/states/authentication.dart';
import 'package:polling_app/utilities.dart';
import 'package:polling_app/screens/main_menu.dart';
import 'package:polling_app/screens/creation_screen.dart';

void main() => runApp(BallotBox());

class BallotBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BallotState(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthenticationState(),
        )
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => Scaffold(
            body: LaunchScreen(),
          ),
          '/main menu':(context) => Scaffold(
            appBar: AppBar(
              title: Text(AppName),
              backgroundColor: Colors.black,
              actions: <Widget>[
                getActions(context),
              ],
            ),
            body: MainMenu(),
          ),
          '/selection': (context) => Scaffold(
            appBar: AppBar(
              title: Text(AppName),
              backgroundColor: Colors.black,
              actions: <Widget>[
                getActions(context),
              ],
            ),
            body: SelectionScreen(),
          ),
          '/creation': (context) => Scaffold(
            appBar: AppBar(
              title: Text(AppName),
              backgroundColor: Colors.black,
              actions: <Widget>[
                getActions(context),
              ],
            ),
            body: CreationScreen(),
          ),
          '/ballotresult': (context) => Scaffold(
            appBar: AppBar(
              title: Text('Results'),
              backgroundColor: Colors.black,
              actions: <Widget>[
              getActions(context),
              ],
              leading: IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/main menu');
                },
              ),
            ),
            body: BalletResults(),
          ),
        },
      )
    );
  }

  PopupMenuButton getActions(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        )
      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          Provider.of<AuthenticationState>(context, listen: false).logout();
          gotoLoginScreen(context);
        }
      },
    );
  }
}

