import 'package:flutter/material.dart';
import 'package:xo/Model/his_model.dart';
import 'package:xo/database/db_service.dart';

class showHistory extends StatefulWidget {
  @override
  _showHistoryState createState() => _showHistoryState();
}

class _showHistoryState extends State<showHistory> {
  void initState() {
    getAllData();
  }

  List<HistoryModel> hisList = new List<HistoryModel>();

  getAllData() async {
    hisList = List<HistoryModel>();
    var service = DBService();
    var his = await service.read();
    his.forEach((list) {
      setState(() {
        var hisModel = HistoryModel();
        hisModel.id = list['id'];
        hisModel.winner = list['winner'];
        hisList.add(hisModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
            itemCount: hisList.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return Container(
                width: screenSize.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    child: SafeArea(
                      child: ListTile(
                        title: Text(hisList[index].winner,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 35)),
                        subtitle: Text('Winner',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                        leading: Image.asset('assets/game.png'),
                        // Text('Player :',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold, fontSize: 35)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            var service = DBService();
                            var delete =
                                await service.deleteOnly(hisList[index].id);
                            getAllData();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
