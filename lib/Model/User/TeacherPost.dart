class TeacherGet {
  String idCard;
  int departmentId;
  String fullName;
  bool gender;
  String birthdate;
  String email;
  String phoneNumber;
  String address;
  bool isHead;

  TeacherGet(this.idCard,
      this.departmentId,
      this.fullName,
      this.gender,
      this.birthdate,
      this.email,
      this.phoneNumber,
      this.address,
      this.isHead,);
  Map<String, dynamic> toJson() => {
    "idCard": idCard,
    "departmentId": departmentId,
    "fullName": fullName,
    "gender": gender,
    "birthdate": birthdate,
    "email": email,
    "phoneNumber": phoneNumber,
    "address": address,
    "isHead": isHead,
};
}