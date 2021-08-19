import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:xo/Model/his_model.dart';
import 'package:xo/Model/model.dart';
import 'package:xo/Pages/history.dart';
import 'package:xo/database/db_service.dart';

class game extends StatefulWidget {
  final int size;

  game(this.size);

  @override
  _gameState createState() => _gameState();
}

class _gameState extends State<game> {
  static const none = '';
  static const X = 'X';
  static const O = 'O';

  String lastMove = none;
  List<List<dynamic>> matrix;

  @override
  void initState() {
    super.initState();

    setEmptyFields();
  }

  void setEmptyFields() {
    setState(() {
      matrix = List.generate(
        widget.size,
        (_) => List.generate(widget.size, (_) => none),
      );
    });
  }

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tic Tac Toe'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(screenSize.height * 0.05),
          width: screenSize.width,
          child: Center(
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Column(
                    children:
                        model.modelBuilder(matrix, (x, value) => buildRow(x)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenSize.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ResetButton(context),
                      HistoryButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text text(String str) => Text(str);

  Widget buildRow(int x) {
    final values = matrix[x];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: model.modelBuilder(
        values,
        (y, value) => buildField(x, y),
      ),
    );
  }

  Widget buildField(int x, int y) {
    var s = 0.5 / widget.size;
    var sizeBoxW = MediaQuery.of(context).size.width * s;
    final value = matrix[x][y];
    return Expanded(
      flex: null,
      child: SizedBox(
        width: sizeBoxW,
        height: sizeBoxW,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Colors.blue,
          ),
          child: AutoSizeText(value, style: TextStyle(fontSize: 15)),
          onPressed: () => selectField(value, x, y),
        ),
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == none) {
      final newValue = lastMove == X ? O : X;
      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        isnertToDB(newValue);
        showEndDialog('Player $newValue Won');
      } else if (isEnd()) {
        isnertToDB('Draw');
        showEndDialog('Draw');
      }
    }
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != none));

  bool isWinner(int x, int y) {
    var col = 0, row = 0, ii = 0, rii = 0;
    final player = matrix[x][y];
    final n = widget.size;
    var win = n;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) {
        col++;
      }
      if (matrix[i][y] == player) {
        row++;
      }
      if (matrix[i][i] == player) {
        ii++;
      }
      if (matrix[i][n - i - 1] == player) {
        rii++;
      }
    }
  
    //for fix size win   
    // if (n >= widget.size) {
    //   win = 4;
    // }

    return row == win || col == win || ii == win || rii == win;
  }

  Future showEndDialog(String title) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text('Press to Play Again the Game'),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setEmptyFields();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again'),
              ),
            )
          ],
        ),
      );

  void isnertToDB(String winner) {
    DBService service = new DBService();
    HistoryModel his = new HistoryModel();
    his.winner = winner;
    var data = his.dataMap();
    service.insert(data);
  }

  ElevatedButton ResetButton(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
      onPressed: () {
        setEmptyFields();
      },
      child: const Text(
        'Restart',
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
