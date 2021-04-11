import 'dart:math';

import 'package:flutter/material.dart';

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> {
  var random = Random.secure();
  var dices = const <String>[
    'images/d1.png',
    'images/d2.png',
    'images/d3.png',
    'images/d4.png',
    'images/d5.png',
    'images/d6.png',
  ];

  var index1 = 0;
  var index2 = 0;
  var score = 0;
  var totalScore = 0;
  var highestScore = 0;
  var newHighestScore = 0;
  var hasStarted = false;
  var hasHitFirst = false;
  var totalScoreB = false;
  var highestScoreB = false;
  var againB = false;

  void _changeDice(){
    setState(() {
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      score += index1 + index2 + 2;
      totalScore = score;

    });
    print('$index1, $index2');
  }

  /*void again(){
    //hasStarted = false;
    _changeDice();

  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(totalScoreB)Text('Total Score: $score', style: TextStyle(fontSize: 30),),
            if(highestScoreB)Text('Highest Score: $highestScore', style: TextStyle(fontSize: 30, color: Colors.red),),
            SizedBox(height: 25,),
            if(hasHitFirst)Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(dices[index1], width: 100, height: 100, fit: BoxFit.cover,),
                Image.asset(dices[index2], width: 100, height: 100, fit: BoxFit.cover,),
              ],
            ),
            SizedBox(height: 25,),

            if(!hasStarted)ElevatedButton(onPressed: (){
              setState(() {
                hasStarted = true;
                totalScoreB= true;
              });
            } , child: Text('Start')),

            if(hasStarted)ElevatedButton(onPressed: (){
              setState(() {
                hasHitFirst = true;

                if(index1 + index2 + 2 != 7) {
                  _changeDice();
                }
                else{
                  hasStarted= false;
                  if (highestScore < totalScore) {
                    highestScore = totalScore;
                    if(highestScore < newHighestScore)
                       highestScore = newHighestScore;
                  }
                  highestScoreB = true;
                  hasHitFirst = false;
                  againB = true;
                  hasStarted= true;
                }
              });
            }, child: Text('Roll')),

            if(againB)ElevatedButton(onPressed: (){
              setState(() {
                index1 = 0;
                index2 = 0;
                score= 0;
                totalScore = 0;
                hasStarted = false;
               // hasHitFirst = false;
                totalScoreB = false;
                highestScoreB = true;
                againB = false;
                //again();
                //_changeDice();
              });
            }, child: Text('Again'),),
          ],
        ),
      ),
    );
  }
}
