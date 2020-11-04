class Ballot {
  String ballotID;
  String ballotName;
  List<Map<String, int>> options;

  Ballot({this.ballotID, this.ballotName, this.options});
}

class Voter {
  String uid;
  String ballotID;
  String markedBallotOption;
}
