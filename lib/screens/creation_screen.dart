import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreationScreen extends StatefulWidget {
  @override
  CreationState createState() => new CreationState();
}

class CreationState extends State<CreationScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _option1 = TextEditingController();
  TextEditingController _option2 = TextEditingController();
  TextEditingController _option3 = TextEditingController();
  final db = Firestore.instance;
  Widget build(BuildContext context) {
      return Scaffold(
        body: ListView(
          padding: EdgeInsets.all(12.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: _title,
                decoration: InputDecoration(hintText: 'Enter Title'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: _option1,
                decoration: InputDecoration(hintText: 'Enter Option 1'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: _option2,
                decoration: InputDecoration(hintText: 'Enter Option 2'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: _option3,
                decoration: InputDecoration(hintText: 'Enter Option 3'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Add'),
                color: Colors.grey,
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, '/main menu');
                  db.collection('Ballots').add({'title': _title.text, _option1.text: 0, _option2.text: 0, _option3.text: 0,});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Cancel'),
                color: Colors.grey,
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, '/main menu');
                },
              ),
            )
          ],
        ),
      );
    }
  }

