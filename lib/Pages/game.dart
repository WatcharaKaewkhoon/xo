import 'package:flutter/material.dart';

class game extends StatefulWidget {
  final int size;

  const game({Key? key, required this.size}) : super(key: key);

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

  int oScore = 0;
  int xScore = 0;
  int count_click = 0;

  @override
  void initState() {
    // super.initState();
    for (int i = 0; i < widget.size * widget.size; i++) {
      data.add('');
    }
  }

  Widget build(BuildContext context) {
    int col = widget.size;
    // data.clear();
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: <Widget>[
          Container(),
          Expanded(
            // Creating the Board for Tic tac toe
            flex: 4,
            child: GridView.builder(
                itemCount: col * col,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: col),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _click(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text(
                          data[index],
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      // child:SizedBox(height: 15,width: 15,),

      // color: Colors.red,
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      // color: Colors.blue,

      //
      // margin: EdgeInsets.only(
      //     top: MediaQuery.of(context).size.height / 10,
      //     left: MediaQuery.of(context).size.width / 10,
      //     right: MediaQuery.of(context).size.width / 10),

      // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/5 ),
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      //  margin: EdgeInsets.all(MediaQuery.of(context).size.height ),
    );
  }

  void _click(int index) {
    setState(() {
      if (oTurn && data[index] == '') {
        data[index] = 'O';
        count_click++;
        print(count_click);
      } else if (!oTurn && data[index] == '') {
        data[index] = 'X';
        count_click++;
        print(count_click);
      }
      else {
        _clearBoard();
      }
      oTurn = !oTurn;
    });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < data.length; i++) {
        data[i] = '';
      }
    });

    count_click = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        data[i] = '';
      }
    });
    count_click = 0;
  }
}
