import 'package:flutter/material.dart';
import 'package:polling_app/states/ballot.dart';
import 'package:polling_app/models/ballot.dart';
import 'package:provider/provider.dart';

class VoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Ballot activeVote = Provider.of<BallotState>(context).activeVote;
    List<String>options = List<String>();

    for (Map<String, int> option in activeVote.options){
      option.forEach((title, value){
       options.add(title);
    });
    }
    return Column(
    children: <Widget>[
      Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Text(
                activeVote.ballotName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
            ),
          )
      ),
      for(String option in options)
        Card(
          child: InkWell(
            onTap: (){
              Provider.of<BallotState>(context, listen: false).selectedOption = option;
              },

            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(minHeight: 60),
                    width: 8,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        option,
                        maxLines: 5,
                        style: TextStyle(
                            color: Provider.of<BallotState>(context).selectedOption == option
                            ?Colors.white
                            :Colors.black,
                            fontSize: 22
                        ),
                      ),
                      color: Provider.of<BallotState>(context).selectedOption == option
                        ?Colors.black
                          :Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        )
    ],
    );
  }
}
