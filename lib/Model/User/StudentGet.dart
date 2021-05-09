
import 'package:edusoft/Model/Class/ClassGet.dart';

class StudentGet {
  String idCard;
  String department;
  String fullName;
  bool gender;
  String birthdate;
  String email;
  String phoneNumber;
  String address;
  List<ClassGet> classes;
  StudentGet(this.address, this.birthdate, this.department, this.email, this.fullName, this.gender, this.idCard, this.phoneNumber, this.classes);
  StudentGet.fromJson(Map<String, dynamic> json)
  {
    idCard = json['idCard'];
    department = json['department'];
    fullName = json['fullName'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    List<ClassGet> classes = [];
    for(var c in json['classes'])
      {
        ClassGet classGet = ClassGet.fromJson(c);
        classes.add(classGet);
      }
    this.classes = classes;
  }
}