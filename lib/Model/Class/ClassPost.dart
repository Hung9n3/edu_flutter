class ClassPost{
final String courseCode;
final String teacherIdCard;
final String room;
final int day;
final String startPeriods;
final String periods;
final String slot;
ClassPost(this.courseCode, this.teacherIdCard, this.room, this.day,
    this.startPeriods, this.slot, this.periods);
Map<String, dynamic> toJson() => {
  'courseCode' : courseCode,
  'teacherIdCard' : teacherIdCard,
  'room' : room,
  'day' : day,
  'startPeriods' : startPeriods,
  'slot': slot,
  'periods' : periods,
};
}