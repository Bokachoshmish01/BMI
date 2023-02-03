
import 'package:bmicalculator/databaseModel.dart';
import 'package:bmicalculator/recordModel.dart';
import 'package:bmicalculator/recordview.dart';
import 'package:flutter/material.dart';

class AddingRecord extends StatefulWidget {
  const AddingRecord({Key? key}) : super(key: key);

  @override
  State<AddingRecord> createState() => _AddingRecordState();
}

class _AddingRecordState extends State<AddingRecord> {
  final _formKey = GlobalKey<FormState>();
  Record _record = Record();
  late DbHeleper _dbHeleper;
  late RecordView _recordView;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dbHeleper=DbHeleper.instance;
    });
  }
  @override
  Widget build(BuildContext context) {
    double bottomInsets=MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Add a Record",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      onSaved: (newValue) {
                        setState(() {
                          _record.name = newValue;
                        });
                        
                      },
                      validator: (value) {
                        return value!.length == 0
                            ? "Field can not be empty!"
                            : null;
                      },
                      scrollPadding: EdgeInsets.only(bottom: bottomInsets+129),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Height",
                        suffixText: "meter",
                      ),
                      onSaved: (newValue) {
                        setState(() {
                          _record.height = newValue;
                        });
                      },
                      validator: (value) {
                        return value!.length == 0
                            ? "Field can not be empty!"
                            : null;
                      },
                       scrollPadding: EdgeInsets.only(bottom: bottomInsets+129),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "weight",
                        suffixText: "Kg",
                      ),
                      onSaved: (newValue) {
                        setState(() {
                          _record.wide = newValue;
                        });
                      },
                      validator: (value) {
                        return value!.length == 0
                            ? "Field can not be empty!"
                            : null;
                      },
                       scrollPadding: EdgeInsets.only(bottom: bottomInsets+129),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: ()async {
                        _calculate();
                        List<Record> list= await _dbHeleper.getRecord();
                        setState(() {
                          
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 225,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.cyan,
                        ),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Your BMI is :",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          _record.bmi==null? "0": " ${_record.bmi!.toStringAsFixed(2) }  ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  _calculate() async{
    var record = _formKey.currentState;
    if (record!.validate()) {
      record.save();
      double a = double.parse(_record.height as String);
      double b = double.parse(_record.wide as String);
      double h = a * a;
      _record.bmi = b / h;
      
     await _dbHeleper.InsertRecord(_record);
     print(_record.bmi);
      // return _record.bmi;
    }
  }
}
