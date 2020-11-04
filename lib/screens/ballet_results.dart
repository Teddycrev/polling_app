import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:polling_app/models/ballot.dart';
import 'package:polling_app/states/ballot.dart';
import 'package:polling_app/services/service.dart';

class BalletResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    retrieveActiveVoteData(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: createChart(context),
    );
  }

  Widget createChart(BuildContext context){
    return Consumer<BallotState>(
      builder: (context,  ballotState, child){
        return charts.BarChart(
          retrieveBallotResults(context),
          animate: true,
        );
      }
    );
  }

  List<charts.Series<BallotData, String>> retrieveBallotResults(BuildContext context){
    Ballot activeVote = Provider.of<BallotState>(context, listen: false).activeVote;

    List<BallotData>data = List<BallotData>();
    for(var option in activeVote.options){
      option.forEach((key, value){
        data.add(BallotData(key, value));
      });
    }

    return[
      charts.Series<BallotData, String>(
        id: 'BallotResult',
        colorFn: (_, pos){
          if(pos % 2 == 0){
            return charts.MaterialPalette.gray.shadeDefault;
        }
          return charts.MaterialPalette.blue.shadeDefault;
        },
        domainFn: (BallotData vote, _) => vote.option,
        measureFn: (BallotData vote, _) => vote.total,
        data: data,
        )
    ];
  }

  void retrieveActiveVoteData(BuildContext context) {
    final ballotID =
        Provider.of<BallotState>(context, listen: false).activeVote?.ballotID;
    retrieveMarkedVoteFromFirestore(ballotID: ballotID, context: context);
  }

}

class BallotData{
  final String option;
  final int total;

  BallotData(this.option, this.total);
}
