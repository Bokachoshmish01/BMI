class Record {

  static const colId="id";
  static const colName="name";
  static const colBmi="bmi";
  static const tblRecords="BmiRecords";

  int? id;
  String? name;
  String? height;
  String? wide;
  double? bmi;

  Record({
    this.name,
    this.height,
    this.wide,
    this.bmi,
  });

  Record.fromMap(Map<String, dynamic> map){
    id=map[colId];
    name=map[colName];
    bmi=map[colBmi];
  }

  Map<String, dynamic> toMap(){
    var map =<String, dynamic>{colName:name,colBmi:bmi!.toStringAsFixed(2)};
    if(id !=null)map[colId]=id;

    return map;
  }
}
