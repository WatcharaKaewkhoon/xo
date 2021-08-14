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
    return Scaffold(
      body: Center(
        key: _formKey,
        child: Container(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
          // width: MediaQuery.of(context).size.width ,
          child: Column(
            children: [
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                controller: size,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Size',
                ),
              ),

              padding(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20)),
                onPressed: () {
                  if(size.text==''){
                    print(null);
                  }else{
                    push(context);
                    print(size.text);
                  }

                },
                child: Text('Play Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void push(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => game(
          size: int.parse(size.text),
          // size: size.text,
        ),
      ),
    );
  }
}

Padding padding() => Padding(
      padding: EdgeInsets.only(top: 10),
    );
