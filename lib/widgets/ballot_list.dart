import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polling_app/states/ballot.dart';
import 'package:polling_app/models/ballot.dart';

class BallotListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String activeBallotID = Provider.of<BallotState>(context).activeVote?.ballotID ?? '';
    return Consumer<BallotState>(
      builder: (context, ballotState, child) {
        return Column(
          children: <Widget>[
            for (Ballot vote in ballotState.ballotList)
              Card(
                child: ListTile(
                  title: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      vote.ballotName,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  selected: activeBallotID == vote.ballotID ? true : false,
                  onTap: (){
                    Provider.of<BallotState>(context, listen: false).activeVote = vote;
                  }
                ),
                color: activeBallotID == vote.ballotID
                    ?Colors.white10
                    :Colors.black,
              ),
          ],
        );
      }
    );
  }
}
