import 'dart:convert';
// import 'dart:html' show window;
import 'package:edusoft/Model/Class/ClassGet.dart';
import 'package:edusoft/Model/Class/ClassPost.dart';
import 'package:edusoft/Model/Course/Courses.dart';
import 'package:edusoft/Model/Department/DepartmentGet.dart';
import 'package:edusoft/Model/Department/DepartmentPost.dart';
import 'package:edusoft/Model/User/StudentGet.dart';
import 'package:edusoft/Model/User/User.dart';
import 'package:edusoft/Model/User/UserGet.dart';
import 'package:edusoft/Model/User/UserGetById.dart';
import 'package:http/http.dart' as http;
import 'package:edusoft/Model/Course/CoursesPost.dart';

var url = 'https://school-management-api.azurewebsites.net/api/';

class Api {
  static Uri createUrl(String controller){
    var _url = Uri.parse(url + controller);
    return _url;
  }
  static Future post(Object body, Uri url) async {
    final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    body: body);
    return response;
  }
  static Future get(Uri url) async {
    final response = await http.get(url);
    return response;
}
static Future update(Object body,Uri url) async {
    final response = await http.put(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: body
    );
    return response;
}
static Future delete(Uri url) async {
    final response = await http.delete(url);
    return response;
}
  static Future login(String a, String b) async
  {
    var _url = Uri.parse(url + 'Auth');
    final response = await http.post(
      (_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': a,
        'password': b,
      }),);
    return response;
  }
  static Future<List<ClassGet>> getClass() async{
    var _url = createUrl('Classes/GetAll');
    final response = await get(_url);
    var data = jsonDecode(response.body);
    List<ClassGet> classGets = [];
    for(var c in data)
      {
        ClassGet classGet = ClassGet.fromJson(c);
        classGets.add(classGet);
      }
    return classGets;
  }
  static Future<List<UserGet>> getAllUserInfo(String role) async {
  var _url = createUrl(role + '/GetAll');
  final response = await get(_url);
  final data = jsonDecode(response.body).cast<Map<String,dynamic>>();
  List<UserGet> users = [];
  for(Map<String,dynamic> u in data)
    {
      UserGet userGet = UserGet.fromJson(u);
      users.add(userGet);
    }
  return users;
  }
  static Future getUserinfo(String role, String id) async {
    var url = createUrl(role + '/Get/' + id);
    final response = await get(url);
    final data = jsonDecode(response.body);
    print('b');
    UserGetById userGetById = UserGetById.fromJson(data);
    return userGetById;
  }
  static Future updateUserinfo(String role, String id, dynamic body) async {
    var url = createUrl(role + '/Update/' + id);
    final response = await update(body, url);
    return response;
  }
  static Future createUser (String role, UserPost userPost) async {
    var url = createUrl(role + '/Create');
    final response = await post(jsonEncode(userPost.toJson()), url);
    return response;
  }
  static Future<StudentGet> getStudentInfo(String role) async {
    var _url = Uri.parse(url + role + '/Get/BTBTIU21001');
    final response = await http.get(_url, );
    final data = jsonDecode(response.body);
    StudentGet studentGet = StudentGet.fromJson(data);
    return studentGet;
  }
  static Future<List<DepartmentGet>> getDepartment() async {
    var _url = createUrl('Departments');
    final response = await get(_url);
    final data = jsonDecode(response.body).cast<Map<String,dynamic>>();
    List<DepartmentGet> departments = [];
    for (Map<String,dynamic> d in data)
    {
      DepartmentGet departmentGet = DepartmentGet.fromJson(d);
      departments.add(departmentGet);
    }
    return departments;
  }
  static Future<List<Course>> getAllCourse() async {
    var url = createUrl('Courses/GetAll');
    final response = await get(url);
    final data = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<Course> courses = [];
    for(Map<String, dynamic> c in data)
      {
        Course course = Course.fromJson(c);
        courses.add(course);
      }
    return courses;
  }
  static Future createDepartment(DepartmentPost departmentPost) async {
    var _url = createUrl('Departments');
    final response = await post(jsonEncode(departmentPost.toJson()), _url);
    return response;
  }
  static Future updateDepartment(DepartmentPost departmentPost, String id) async {
    var url = createUrl('Departments/' + id);
    final resposne = await update(jsonEncode(departmentPost.toJson()), url);
    return resposne;
  }
  static Future deleteDepartment(String id) async {
    var url = createUrl('Departments/' + id);
    final response = await delete(url);
    return response;
}
  static Future createCourse(CoursesPost coursePost) async {
    var url = createUrl('Courses/Create');
    final response = await post(jsonEncode(coursePost.toJson()), url);
    return response;
  }
  static Future createClasses(ClassPost classPost) async {
    var url = createUrl('Classes/Create');
    final response = await post(jsonEncode(classPost.toJson()), url);
    return response;
  }

  static Future updateClasses(ClassPost classPost, int id) async {
    var url = createUrl('Classes/' + id.toString());
    final response = await update(jsonEncode(classPost.toJson()), url);
    return response;
  }
  static Future updateCourses(CoursesPost coursesPost, int id) async {
    var url = createUrl('Courses/Update/' + id.toString());
    final response = await update(jsonEncode(coursesPost.toJson()), url);
    return response;
  }
  static Future deleteCourse(int id) async {
    var url = createUrl('Courses/Delete/' + id.toString());
    final response = await delete(url);
    return response;
  }
  static Future deleteAny(String route, String id) async {
    var url = createUrl(route + '/Delete/' + id);
    print(url);
    final response = await delete(url);
    return response;
  }
}
