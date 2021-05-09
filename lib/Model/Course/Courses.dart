

class Course {
 String name;
 int id;
 String department;
 int credits;
 String courseCode;
 int classes;
 Course( this.name, this.id, this.department, this.credits );
 Course.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  id = json['id'];
  department = json['department'];
  credits = json['credits'];
  courseCode = json['courseCode'];
  classes = json['classes'];
 }
}