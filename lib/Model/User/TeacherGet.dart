import 'package:edusoft/Model/Class/ClassGet.dart';

class TeacherGet {
  String idCard;
  String departmentId;
  String fullName;
  bool gender;
  DateTime birthdate;
  String email;
  String phoneNumber;
  String address;
  bool isHead;
  List<ClassGet> classes;
  TeacherGet(
    this.idCard,
    this.departmentId,
    this.fullName,
    this.gender,
    this.birthdate,
    this.email,
    this.phoneNumber,
    this.address,
    this.isHead,
      this.classes,
  );
   TeacherGet.fromJson(Map<String, dynamic> json)  {
    idCard= json["idCard"];
    departmentId= json["departmentId"];
    fullName= json["fullName"];
    gender= json["gender"];
    birthdate= DateTime.parse(json["birthdate"]);
    email= json["email"];
    phoneNumber= json["phoneNumber"];
    address= json["address"];
    isHead= json["isHead"];
    for(var c in json['classes'])
    {
      ClassGet classGet = ClassGet.fromJson(c);
      classes.add(classGet);
    }
    this.classes = classes;
   }
}