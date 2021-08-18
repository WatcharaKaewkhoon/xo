import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xo/Pages/game.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  var size = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        key: _formKey,
        child: Wrap(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(screenSize.width*0.05),
                width: screenSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/game.png',color: Colors.red,fit: BoxFit.contain,width: screenSize.width,height: screenSize.height*0.5),
                    TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      controller: size,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // focusedBorder: OutlineInputBorder(),
                        labelText: 'Enter Size Minimum 3',
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: playgame(context,'Play Game'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton playgame(BuildContext context, String str) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20),),
      onPressed: () {
        if (size.text == '' || size.text=='1'||size.text=='2') {
          showEndDialog('Please enter size minimum 3 ');
        } else {
          push(context);
        }
      },
      child: Text(str),
    );
  }

  void push(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => game(
          int.parse(size.text),
          // size: size.text,
        ),
      ),
    );
  }
  Future showEndDialog(String title) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(title),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        )
      ],
    ),
  );
}

Padding padding() => Padding(
      padding: EdgeInsets.only(top: 10),
    );
