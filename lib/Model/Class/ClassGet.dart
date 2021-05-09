
class ClassGet {
   String classCode ;
   String course ;
   String department;
   String teacher ;
   String room ;
   int day ;
   int startPeriods ;
   int periods ;
   int slot ;
   int restSlot ;
   String students;
   int id ;
  ClassGet(this.periods, this.slot, this.startPeriods, this.day, this.classCode, this.course
      , this.id, this.restSlot, this.room, this.students, this.teacher, this.department);
  ClassGet.fromJson(Map<String,dynamic> json)
  {
    classCode = json['classCode'];
    startPeriods = json['startPeriods'];
    course = json['course'];
    department = json['department'];
    teacher = json['teacher'];
    room = json['room'];
    day = json['day'];
    periods = json['periods'];
    slot = json['slot'];
    restSlot = json['restSlot'];
    id = json['id'];
  }
}



