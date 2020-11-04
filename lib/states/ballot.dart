
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polling_app/models/ballot.dart';
import 'package:polling_app/services/service.dart';

class BallotState with ChangeNotifier {
  List <Ballot> _ballotList = List<Ballot>();
  Ballot _activeVote;
  String _selectedOption;

  void loadBallotList(BuildContext context) async{
    getBallotListFromFirestore(context);
  }

  void clearState() async{
    _ballotList = null;
    _activeVote = null;
    _selectedOption = null;
  }

  List <Ballot> get ballotList => _ballotList;
  set ballotList(newValue){
    _ballotList = newValue;
    notifyListeners();
  }
  Ballot get activeVote => _activeVote;
  String get selectedOption => _selectedOption;

  set activeVote(newValue) {
    _activeVote = newValue;
    notifyListeners();
  }

  set selectedOption(String newValue){
    _selectedOption = newValue;
    notifyListeners();
  }
}