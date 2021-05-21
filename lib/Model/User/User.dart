

class UserPost {
  UserPost(
      this.idCard,
    this.classes,
    this.departmentId,
    this.fullName,
    this.gender,
    this.birthdate,
    this.email,
    this.phoneNumber,
    this.address,
    this.isHead,
  );
  String idCard;
  int departmentId;
  String fullName;
  bool gender;
  String birthdate;
  String email;
  String phoneNumber;
  String address;
  bool isHead = false;
  List<int> classes;

  Map<String, dynamic> toJson() => {
    'idCard' : idCard,
    "departmentId": departmentId,
    "fullName": fullName,
    "gender": gender,
    "birthdate": birthdate,
    "email": email,
    "phoneNumber": phoneNumber,
    "address": address,
    "isHead" : isHead,
    "classes" : classes
  };
}
