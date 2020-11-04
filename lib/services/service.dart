import 'package:flutter/material.dart';
import'package:polling_app/models/ballot.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:polling_app/states/ballot.dart';

List<Ballot> getballotList() {
  // Fake data for demo
  List<Ballot> ballotList = List<Ballot>();

  ballotList.add(Ballot(
    ballotID: Uuid().v4(),
    ballotName: 'Best Star Wars trilogy?',
    options: [
      {'Prequel': 23},
      {'Original': 65},
      {'Newest': 18},
    ],
  ));

  ballotList.add(Ballot(
    ballotID: Uuid().v4(),
    ballotName: 'Best Spider-Man movie?',
    options: [
      {'Spider-Man: Homecoming': 51},
      {'Spider-Man 2': 55},
      {'Into the Spiderverse': 48},
    ],
  ));

  return ballotList;
}

const String kBallots = 'Ballots';
const String kName = 'title';

void getBallotListFromFirestore(BuildContext context) async {
      Firestore.instance.collection(kBallots).snapshots().listen((data) {
    List<Ballot> ballotList = List<Ballot>();

    data.documents.forEach((DocumentSnapshot document) {
      Ballot vote = Ballot(ballotID: document.documentID);

      List<Map<String, int>> options = List();

      document.data.forEach((key, value) {
        if (key == kName) {
          vote.ballotName = value;
        } else {
          options.add({key: value});
        }
      });

      vote.options = options;
      ballotList.add(vote);
    });

    Provider.of<BallotState>(context, listen: false).ballotList = ballotList;
  });

      Firestore.instance.collection(kBallots).getDocuments().then((snapshot) {
        List<Ballot> ballotList = List<Ballot>();

        snapshot.documents.forEach((DocumentSnapshot document) {
          ballotList.add(mapFirestoreDocToBallot(document));
        });

        Provider.of<BallotState>(context, listen: false).ballotList = ballotList;
      });
    }


Ballot mapFirestoreDocToBallot(document) {
  Ballot vote = Ballot(ballotID: document.documentID);
  List<Map<String, int>> options = List();
  document.data.forEach((key, value) {
    if (key == kBallots) {
      vote.ballotName = value;
    } else {
      options.add({key: value});
    }
  });

  vote.options = options;
  return vote;
}

void markVote(String ballotID, String option) async {
  Firestore.instance.collection(kBallots).document(ballotID).updateData({
    option: FieldValue.increment(1),
  });
}

void retrieveMarkedVoteFromFirestore({String ballotID, BuildContext context}) {
  // Retrieve updated doc from server
  Firestore.instance.collection(kBallots).document(ballotID).get().then((document) {
    Provider.of<BallotState>(context, listen: false).activeVote =
        mapFirestoreDocToBallot(document);
  });
}