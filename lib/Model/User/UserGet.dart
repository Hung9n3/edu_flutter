

class UserGet {
  String idCard;
  String department;
  String fullName;
  bool gender;
  String birthdate;
  String email;
  String phoneNumber;
  String address;
  bool isHead;
  UserGet(this.address, this.birthdate, this.department, this.email, this.fullName, this.gender, this.idCard, this.phoneNumber);
  UserGet.fromJson(Map<String, dynamic> json)
  {
    idCard = json['idCard'];
    department = json['department'];
    fullName = json['fullName'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    isHead = json['isHead'];
  }
}