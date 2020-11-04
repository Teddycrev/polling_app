import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
        resizeToAvoidBottomPadding: false,

      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(
              left: 10.0, right: 10.0, top: 100.0, bottom: 10.0 ),
          child:ButtonTheme(
            minWidth: 100,
            height: 100,
            child:RaisedButton(
                textColor: Colors.white,
                color: Colors.black,
                child: Text(
                  'Vote on Ballot',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/selection');
                }
            )
          ),
        ),
            SizedBox(
              height: 100,
            ),
            Container(
              child:ButtonTheme(
                  minWidth: 100,
                  height: 100,
                  child:RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text(
                        'Create a Ballot',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/creation');
                      }
                  )
              ),
            )
      ]),
    ));
  }
}

