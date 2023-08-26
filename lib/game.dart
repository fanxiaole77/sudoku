import 'package:flutter/material.dart';
import 'package:sudoku/main.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  bool oTurn = true;

  List<String> displayXO = [" "," "," "," "," "," "," "," "," "];

  String resultDeclaration = " ";

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  bool winnerFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.pinkAccent
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              width: 600,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("玩家O分数:${oScore}",style: TextStyle(fontSize: 46),),
                  Text("玩家X分数:${xScore}",style: TextStyle(fontSize: 46),),
                ],
              ),
            ),
            Container(
              width: 600,
              height: 600,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 5,
                              color: Colors.pinkAccent
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300]
                      ),
                      child: Center(
                        child: Text(
                            displayXO[index],
                            style: TextStyle(
                            fontSize: 64,
                            color: Colors.pinkAccent
                        ),),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              setState(() {
                _clearBoard();
              });
            }, child: Text("重新开始"))
          ],
        ),
      ),
    );
  }
  void _tapped(int index){
    setState(() {
      if(oTurn && displayXO[index] == " "){
        displayXO[index] = "O";
        filledBoxes++;
      }else if(!oTurn && displayXO[index] == " "){
        displayXO[index] = "X";
        filledBoxes++;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }
  void _checkWinner(){
    if(displayXO[0] == displayXO[1] && displayXO[0] == displayXO[2] && displayXO[0] != " "){
      setState(() {
        _updateScore(displayXO[0]);
        show(displayXO[0]);
      });
    }else if(displayXO[3] == displayXO[4] && displayXO[3] == displayXO[5] && displayXO[3] != " "){
      setState(() {
        _updateScore(displayXO[3]);
        show(displayXO[3]);
      });
    }else if(displayXO[6] == displayXO[7] && displayXO[6] == displayXO[8] && displayXO[6] != " "){
      setState(() {
        _updateScore(displayXO[6]);
        show(displayXO[6]);
      });
    }else if(displayXO[0] == displayXO[3] && displayXO[0] == displayXO[6] && displayXO[0] != " "){
      setState(() {
        _updateScore(displayXO[0]);
        show(displayXO[0]);

      });
    }else if(displayXO[1] == displayXO[4] && displayXO[1] == displayXO[7] && displayXO[1] != " "){
      setState(() {
        _updateScore(displayXO[1]);
        show(displayXO[1]);

      });
    }else if(displayXO[2] == displayXO[5] && displayXO[2] == displayXO[8] && displayXO[2] != " "){
      setState(() {
        _updateScore(displayXO[2]);
        print(displayXO[8].toString());
        show(displayXO[2]);

      });
    }else if(displayXO[0] == displayXO[4] && displayXO[0] == displayXO[8] && displayXO[0] != " "){
      setState(() {
        _updateScore(displayXO[0]);
        show(displayXO[0]);
      });
    }else if(displayXO[2] == displayXO[4] && displayXO[2] == displayXO[6] && displayXO[2] != " "){
      setState(() {
        _updateScore(displayXO[2]);
        show(displayXO[2]);
      });
    }else if(!winnerFound && filledBoxes == 9){
      setState(() {
        show1();
      });
    }

  }
  void show(String a){
   showDialog(
       context: context,
       builder: (BuildContext context){
         return AlertDialog(
           title:Text("恭喜你赢了${a}"),
           actions: [
             TextButton(onPressed: (){
               setState(() {
                 _clearBoard();
               });
               Navigator.pop(context);
             }, child: Text("确定"))
           ],
         );
       }
   );
  }
  void show1(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title:Text("双方平局"),
            actions: [
              TextButton(onPressed: (){
                setState(() {
                  _clearBoard();
                });
                Navigator.pop(context);
              }, child: Text("确定"))
            ],
          );
        }
    );
  }
  void _updateScore(String winner){
    if(winner == "O"){
      oScore++;
    }else if(winner == "X"){
      xScore++;
    }
    winnerFound = true;
  }
  void _clearBoard(){
    for(int i=0;i<9;i++){
      displayXO[i] = " ";
    }
    resultDeclaration = " ";
    filledBoxes = 0;
  }
}
