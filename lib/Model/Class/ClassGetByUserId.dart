
class ClassGetByUserId {
  String classCode ;
  int courseId ;
  String teacherId ;
  String room ;
  int day ;
  int startPeriods ;
  int periods ;
  int slot ;
  int restSlot ;
  String students;
  int id ;
  ClassGetByUserId(this.periods, this.slot, this.startPeriods, this.day, this.classCode, this.courseId
      , this.id, this.restSlot, this.room, this.students, this.teacherId);
  ClassGetByUserId.fromJson(Map<String,dynamic> json)
  {
    classCode = json['classCode'];
    startPeriods = json['startPeriods'];
    courseId = json['courseId'];
    teacherId = json['teacherId'];
    room = json['room'];
    day = json['day'];
    periods = json['periods'];
    slot = json['slot'];
    restSlot = json['restSlot'];
    id = json['id'];
  }
}



