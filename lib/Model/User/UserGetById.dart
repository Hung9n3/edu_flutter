

import 'package:edusoft/Model/Class/ClassGet.dart';

class UserGetById {
  String idCard;
  String department;
  String fullName;
  bool gender;
  String birthdate;
  String email;
  String phoneNumber;
  String address;
  bool isHead;
  List<ClassGet> classes;
  UserGetById(this.address, this.birthdate, this.department, this.email, this.fullName, this.gender, this.idCard, this.phoneNumber, this.classes);
  UserGetById.fromJson(Map<String, dynamic> json)
  {
    idCard = json['idCard'];
    department = json['department'];
    fullName = json['fullName'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    if(json['isHead'] != null) isHead = json['isHead'];
    else isHead = false;
    List<ClassGet> classes = [];
    for(var c in json['classes'])
    {
      ClassGet classGet = ClassGet.fromJson(c);
      classes.add(classGet);
    }
    this.classes = classes;
  }
}