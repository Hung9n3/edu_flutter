
class CoursesPost {
  final courseCode;
  final int departmentId ;
  final String name;
  final int credits;
  CoursesPost(this.name, this.credits, this.departmentId, this.courseCode);
  Map<String, dynamic> toJson() => {
    'departmentId' : departmentId,
    'name' : name,
    'credits' : credits,
    'courseCode' : courseCode
  };
}