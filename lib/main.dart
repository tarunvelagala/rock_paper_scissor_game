import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Rock Paper Scissors"),
        ),
        body: Rps(),
      ),
    );
  }
}

class Rps extends StatefulWidget {
  @override
  _RpsState createState() => _RpsState();
}

class _RpsState extends State<Rps> {
  List<IconData> icons = [
    FontAwesomeIcons.handRock,
    FontAwesomeIcons.handPaper,
    FontAwesomeIcons.handScissors
  ];
  List<String> names = ['Rock', 'Paper', 'Scissors'];
  int choice;
  String oresult = '';
  int cpuChoice = 1;
  int turn = 0;
  int usrOrCpu;
  String result;
  String draw = "";
  int random() {
    final rdm = Random();
    int min = 1;
    int max = 4;
    int rnd = min + rdm.nextInt(max - min);
    return rnd;
  }

  _itsCpuTurn(choice, cpuChoice) {
    if (choice == cpuChoice) {
      result = "draw";
    } else if ((choice == 1 && cpuChoice == 2) ||
        (choice == 2 && cpuChoice == 1)) {
      result = "paper";
    } else if ((choice == 1 && cpuChoice == 3) ||
        (choice == 3 && cpuChoice == 1)) {
      result = "rock";
    } else {
      result = "scissors";
    }
    if (result == "draw") {
      setState(() {
        draw = "DRAW";
      });
    } else if (result == names[choice - 1].toLowerCase()) {
      setState(() {
        oresult = "YOU";
        draw = "";
      });
    } else {
      setState(() {
        oresult = "CPU";
        draw = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[_userInput(1), _userInput(2), _userInput(3)],
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            height: 100.0,
            width: 120.0,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      names[cpuChoice - 1],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Icon(
                      icons[cpuChoice - 1],
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: draw == "draw".toUpperCase()
                ? Text(draw.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ))
                : Text(
                    "WINNER: " + oresult,
                    style: TextStyle(fontSize: 20.0),
                  ),
          )
        ],
      ),
    );
  }

  _userInput(index) {
    return Container(
      width: 120.0,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  names[index - 1],
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Icon(
                  icons[index - 1],
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              int r = random();
              choice = index;
              cpuChoice = r;
              // turn = 1;
            });
            //print("User Choice " + choice.toString());
            // print("Cpu Choice " + cpuChoice.toString());
            _itsCpuTurn(choice, cpuChoice);
          },
        ),
      ),
    );
  }
}
