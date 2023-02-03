

import 'package:bmicalculator/databaseModel.dart';
import 'package:bmicalculator/recordModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RecordView extends StatefulWidget {
  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  List<Record> _recordlist = [];

  late DbHeleper _dbHeleper;
  _records() async {
    List<Record> r = await _dbHeleper.getRecord();
    setState(() {
      _recordlist = r;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dbHeleper = DbHeleper.instance;
    });
    _records();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Records",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.cyan,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: _recordlist.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _recordlist.length,
              itemBuilder: (context, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text("${_recordlist[i].name}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          Text("${_recordlist[i].bmi!.toStringAsFixed(2)}"),
                           (_recordlist[i].bmi! < 18.5)
                        ? Text("Underweight!",style: TextStyle(
                          color: Colors.orange[900],
                        ),)
                        : (_recordlist[i].bmi! >= 18.5 &&
                                _recordlist[i].bmi! <= 24.9)
                            ? Text("Good",style: TextStyle(
                              color: Colors.green,
                            ),)
                            : (_recordlist[i].bmi! >= 25 &&
                                    _recordlist[i].bmi! <= 29.9)
                                ? Text("Overweight",style: TextStyle(
                                  color: Colors.red,
                                ),)
                                : Text("Obsity",style: TextStyle(
                                  color: Colors.red[900],
                                ),),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.cyan[400],
                        ),
                        onPressed: () async {
                          await _dbHeleper
                              .deleteRecord(_recordlist[i].id as int);
                          _records();
                        },
                      ),
                    ),
                   
                    Divider(),
                  ],
                );
              },
            ),
    );
  }
}
