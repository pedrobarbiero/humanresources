import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:humanresources/src/shared/base_model.dart';

class Person extends BaseModel {
  String name;
  bool active;
  DateTime birthDate;

  Person();

  Person.fromMap(Map<String, dynamic> map) {
    this.name = map["name"];
    this.active = map["active"] ?? false;
    Timestamp timestamp = map["birthDate"];        
    this.birthDate = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);        
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = this.name;
    map['active'] = this.active;
    map['birthDate'] = this.birthDate;
    return map;
  }
}
