import 'package:flutter/material.dart';
import 'package:xo/Model/his_model.dart';
import 'package:xo/Pages/history.dart';
import 'package:xo/database/db_service.dart';

class game extends StatefulWidget {
  final int size;

  game(this.size);

  // const game({required this.size});
  // final String size;
  //  game({required this.size});

  @override
  _gameState createState() => _gameState();
}

class _gameState extends State<game> {
  bool oTurn = true;
  bool check = true;
  List<String> data = [];
  List<List<String>> dataStr = [];
  List<String> dataCopy = [];
  List<List<dynamic>> dataCopy2 = [];

  int oScore = 0;
  int xScore = 0;
  int count_click = 0;

  @override
  void initState() {
    super.initState();
    int row = widget.size;
    int col = widget.size;
    int count = 0;

    var dataGrid = List.generate(row, (i) => List(col), growable: false);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        dataGrid[i][j] = '';
        count++;
      }
    }

    for (int i = 0; i < widget.size * widget.size; i++) {
      data.add('');
      dataCopy.add('');
      // if(i<widget.size){
      //   dataRow.add('');
      // }
    }
  }

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    int col = widget.size;
    // data.clear();
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Colors.green,
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        margin: EdgeInsets.all(screenSize.height * 0.05),
        child: Container(
          // color: Colors.blue,
          // height: screenSize.height,
          // width: screenSize.width,
          child: Wrap(
            children: <Widget>[
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          text('Player X'),
                          text('Score : $xScore')
                        ],
                      ),
                      // Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          text('Player O'),
                          text('Score : $oScore')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    // CreatingBoard for Tic tac toe
                    flex: 1,
                    child: Container(
                      width: screenSize.width * 0.5,
                      // height: screenSize.height*0.5,
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: col * col,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: col),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                _click(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.blueAccent)),
                                child: Center(
                                  child: Text(
                                    data[index],
                                    style: TextStyle(fontSize: 35),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RescoreButton(context),
                  HistoryButton(context),

                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       textStyle: TextStyle(fontSize: 20)),
                  //   onPressed: () {
                  //
                  //   },
                  //   child: const Text('Play Again'),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text text(String str) => Text(str);

  void _click(int index) {
    print(index);

    int count = 0;
    int row = widget.size;
    int col = row;
    setState(() {
      if (oTurn && data[index].isEmpty) {
        print(data[index]);
        data[index] = 'O';
        count_click++;
      } else if (!oTurn && data[index].isEmpty) {
        data[index] = 'X';
        count_click++;
      }
      _checkWinner();
      oTurn = !oTurn;
    });
  }

  void _checkWinner2() {
    int i = 0;
    int j = 0;
    int col = widget.size * widget.size;
    int row = widget.size;

    String xCol = '';
    String oCol = '';
    int count = 0;

    //
    // for(int i=0;i<row;i++){
    //   for(int j=0;j<col;j++){
    //     dataCopy2[i][j]=count;
    //     count++;
    //   }
    // }
    //
    // print(dataCopy2);
    // dataCopy = data;
    // var dataGrid = List.generate(row, (i) => List(col), growable: false);
    // for(i;i<row;i++){
    //   for(j;j<col;j++){
    //     dataGrid[i][j]=data[j];
    //
    //     print(dataGrid[i][j]=data[j]);
    //   }
    // }
    // print(dataGrid);

//For fill;

    //
    //
    //   // if(i%col==0){
    //   //   print(data[i-1]);
    //   //   dataRow[count]=data[i-1];
    //   //   count++;
    //   //
    //   // }
    //
    // }

    // print(count);

    //
    // print(dataCopy);
    // for (int j = 0; j < dataCopy.length; j++) {
    //   if (dataCopy[j] == 'X') {
    //     xCol += dataCopy[j];
    //   } else if (dataCopy[j] == 'O') {
    //     oCol += dataCopy[j];
    //   }
    // }
    // if (xCol.length == dataCopy.length) {
    //   _showWinDialog('Player X');
    //   xScore++;
    //   // print('WInner is X');
    //
    // } else if (oCol.length == dataCopy.length) {
    //   _showWinDialog('Player O');
    //   oScore++;
    //   // print('WInner is O');
    // }
    // print(count);
  }

  //CheckCol

  void isnertToDB(String winner) {
    DBService service = new DBService();
    HistoryModel his = new HistoryModel();
    his.winner = winner;
    print(winner);

    var data = his.dataMap();
    service.insert(data);
    // service.winner;
    // service
  }

  void _checkWinner() {
    // dataCopy = data;
    // Checking rows
    if (data[0] == data[1] && data[0] == data[2] && data[0] != '') {
      _showWinDialog(data[0]);
      isnertToDB(data[0]);
    }
    if (data[3] == data[4] && data[3] == data[5] && data[3] != '') {
      _showWinDialog(data[3]);
      isnertToDB(data[3]);
    }
    if (data[6] == data[7] && data[6] == data[8] && data[6] != '') {
      _showWinDialog(data[6]);
      isnertToDB(data[6]);
    }

    // Checking Column
    if (data[0] == data[3] && data[0] == data[6] && data[0] != '') {
      _showWinDialog(data[0]);
      isnertToDB(data[0]);
    }
    if (data[1] == data[4] && data[1] == data[7] && data[1] != '') {
      _showWinDialog(data[1]);
      isnertToDB(data[1]);
    }
    if (data[2] == data[5] && data[2] == data[8] && data[2] != '') {
      _showWinDialog(data[2]);
      isnertToDB(data[2]);
    }

    // Checking Diagonal
    if (data[0] == data[4] && data[0] == data[8] && data[0] != '') {
      _showWinDialog(data[0]);
      isnertToDB(data[0]);
    }
    if (data[2] == data[4] && data[2] == data[6] && data[2] != '') {
      _showWinDialog(data[2]);
      isnertToDB(data[2]);
    } else if (count_click == data.length) {
      _showDrawDialog();
      isnertToDB('Draw');
    }
    // }
    // if(count_click>=data.length){
    //
    //   }
    // print(count_click);

    // print(dataCopy);

    // for(int i=0;i<data.length;i++){
    //   if(i.isEven){
    //     print(i);
    //   }
    //   // print(i);
    //   // if(data[0]==data[i])
    //
    // }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\ " + winner + " \ is Winner!!!"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _clearDataCopy() {
    dataCopy.clear();
    setState(() {
      for (int i = 0; i < dataCopy.length; i++) {
        dataCopy[i] = '';
      }
    });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < data.length; i++) {
        data[i] = '';
        dataCopy[i] = '';
      }
      // for(int i=0;i<widget.size;i++){
      //   dataRow[i]='';
      // }
    });
    count_click = 0;
  }

  void _clearScore() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < data.length; i++) {
        data[i] = '';
      }
    });
    count_click = 0;
  }

  ElevatedButton RescoreButton(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
      onPressed: () {
        _clearScore();
      },
      child: const Text(
        'Rescore',
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton HistoryButton(
    BuildContext context,
  ) {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => showHistory(),
            // size: size.text,
          ),
        );
      },
      child: const Text(
        'History',
        textAlign: TextAlign.center,
      ),
    );
  }
}
