import 'package:flutter/material.dart';
import 'package:polling_app/widgets/ballot.dart';
import 'package:polling_app/widgets/ballot_list.dart';
import 'package:provider/provider.dart';
import 'package:polling_app/states/ballot.dart';
import 'package:polling_app/services/service.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BallotState>(context, listen: false).clearState();
      Provider.of<BallotState>(context, listen: false).loadBallotList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          if (Provider.of<BallotState>(context, listen: false).ballotList ==
              null)
            Container(
              color: Colors.black,
              child: Center(
                child:
                Loading(indicator: BallPulseIndicator(), size: 100.0),
              ),
            ),
          if (Provider.of<BallotState>(context, listen: true).ballotList != null)
          Expanded(
            child: Stepper(type: StepperType.horizontal, currentStep: currentStep,
              steps: [
                getStep(
                  title: 'Choose',
                  child: BallotListWidget(),
                  isActive: true,
              ),
                getStep(
                  title: 'Vote',
                  child: VoteWidget(),
                  isActive: currentStep>= 1 ? true : false,
                ),
            ],

              onStepContinue: () {
              if(currentStep == 0){
                if(step2Required()){
                  setState(() {
                    currentStep = (currentStep + 1) > 1 ? 1 : currentStep + 1;
                  });
                } else{
                  showSnackBar(context, 'Please select a ballot first.');
                }
              }else if (currentStep == 1){
                if(step3Required()){
                  markMyVote();
                  Navigator.pushReplacementNamed(context, '/ballotresult' );
                }else{
                  showSnackBar(context, 'Please select an option first.');
                }
              }
              },
              onStepCancel: () {
              if (currentStep <= 0){
                Provider.of<BallotState>(context, listen: false).activeVote = null;
                Navigator.pushReplacementNamed(context, '/main menu');
              } else if (currentStep <= 1) {
                Provider.of<BallotState>(context, listen: false).selectedOption = null;
              }
                setState(() {
                  currentStep = (currentStep - 1) < 0 ? 0 : currentStep - 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  bool step2Required() {
    if (Provider.of<BallotState>(context, listen: false).activeVote == null){
      return false;
    }
      return true;
  }

  bool step3Required() {
    if (Provider.of<BallotState>(context, listen: false).selectedOption == null){
      return false;
    }
    return true;
  }

  void showSnackBar(BuildContext, String msg){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 22),
      ),
    ));
  }

  Step getStep({String title, Widget child, bool isActive = false}){
    return Step(
      title: Text(title),
      content: child,
      isActive: isActive,
    );
  }

  void markMyVote() {
    final ballotID =
        Provider.of<BallotState>(context, listen: false).activeVote.ballotID;
    final option = Provider.of<BallotState>(context, listen: false)
        .selectedOption;

    markVote(ballotID, option);
  }

}
