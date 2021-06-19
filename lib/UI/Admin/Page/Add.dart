import 'package:edusoft/Model/Course/Courses.dart';
import 'package:edusoft/Model/Course/CoursesPost.dart';
import 'package:edusoft/Model/Department/DepartmentGet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edusoft/Api/api.dart' show Api;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show window;

class AddCourse extends StatefulWidget {
  @override
  _AddCourse createState() => _AddCourse();
}

class _AddCourse extends State<AddCourse> {

  String courseCode;
  int departmentId ;
  CoursesPost coursesPost;
  List<DepartmentGet> departments = [];
  List<Course> courses = [];
  TextEditingController name = TextEditingController();
  int credit ;
  List<int> credits = [1,2,3,4,5];
  Future getDepartment() async {
    final departments = await Api.getDepartment();
    setState(() {
      this.departments = departments;
    });
    final courses = await Api.getAllCourse();
    setState(() {
      this.courses = courses;
    });
    print(window.location.href);
    return this.departments;
  }
  void showAdd() {
    showDialog(context: context,
        builder: (BuildContext context) {
            return AlertDialog(
              actions: [
                TextButton(onPressed: () async {
                  var response = await createCourse();
                }, child: Text('Save')),
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                  reload();},
                    child: Text('Close'))
              ],
              title:Text('Add Course'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    height: 250,
                    width: 350,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Course name'
                              ),
                            )
                          ),
                          Container(padding: EdgeInsets.all(5),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Choose a department'),
                            value: departmentId,
                            onChanged: (int newValue ){
                              setState((){departmentId = newValue;});
                            },
                            items: departments.map((e) => DropdownMenuItem(value: e.Id,child: Text(e.name))).toList(),
                          ),
                          ),
                          Padding(padding: EdgeInsets.all(5),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Choose credit'),
                              value: credit,
                              onChanged: (int newValue ){
                                setState(() {
                                  credit = newValue;
                                });
                              },
                              items: credits.map((e) => DropdownMenuItem(value: e,child: Text(e.toString()))).toList(),
                            ),
                          )
                        ],
                      )
                    ),
                  );
                },
              ) ,
            );
        }
    );
  }
  void showEdit(Course data) {
    TextEditingController name = TextEditingController(text: data.name);
    for(var d in departments)
      {
        for(var c in credits){
        if(data.department == d.name && data.credits == c)
          {
            departmentId = d.Id;
            credit = data.credits;
            break;
          }
        }
      }
    showDialog(context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        actions: [
          TextButton(child: Text('Save'), onPressed: (){
            setState(() async {
              CoursesPost course = CoursesPost(name.text, credit, departmentId, data.courseCode);
              final response = await Api.updateCourses(course, data.id);
            });
          },),
          TextButton(onPressed: (){setState(() {
            Navigator.of(context).pop();
            reload();
          });}, child: Text('Close'))
        ],
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 400,
              width: 350,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child:TextField(
                        controller: name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name'
                        ),
                      )
                    ),
                    Container(padding: EdgeInsets.all(5),
                    child: DropdownButton(
                      value: departmentId,
                      hint: Text('Choose a department'),
                      onChanged: (int value){
                        setState((){
                          departmentId = value;
                        });
                      },
                      items: departments.map((e) => DropdownMenuItem(child: Text(e.name), value: e.Id,)).toList(),
                    )),
                    Container(padding: EdgeInsets.all(5),
                        child: DropdownButton(
                          value: credit,
                          hint: Text('Choose a department'),
                          onChanged: (int value){
                            setState((){
                              credit = value;
                            });
                          },
                          items: credits.map((e) => DropdownMenuItem(child: Text(e.toString()), value: e,)).toList(),
                        )),
                  ],
                )
              ),
            );
          },
        ),
      );
    });
  }
  Future createCourse() async {
    coursesPost = CoursesPost(this.name.text, this.credit, this.departmentId, this.courseCode);
    print(coursesPost.toJson());
    final response = await Api.createCourse(coursesPost);
    return response;
  }
  void reload() {
    Navigator.popAndPushNamed(context, '/Courses');
  }
  Future init() async {
    final departments = await getDepartment();
    this.departments = departments;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: Column (
        children: [
          Container(child: Row(
            children: [
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                setState(() {
                  Navigator.of(context).pop();
                });
              })
            ],
          )),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextButton(
                    onPressed: showAdd,
                    child: Text('Add new course')
                  ),
                ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30.0,0,0),
            child: Container(
              height: 500,
                child: SingleChildScrollView(
                  child: DataTable(
                      columns: [
                        DataColumn(label: Text('Id')),
                        DataColumn(label: Text('Code')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Department')),
                        DataColumn(label: Text('Class amount')),
                        DataColumn(label: Text('Credits')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                      ],
                      rows: courses.map((data) {
                        // print(data.classCode);
                        return DataRow(
                            cells: [
                              DataCell(Text(data.id.toString())),
                              DataCell(Text(data.courseCode)),
                              DataCell(Text(data.name)),
                              DataCell(Text(data.department)),
                              DataCell(Text(data.classes.toString())),
                              DataCell(Text(data.credits.toString())),
                              DataCell(TextButton(child: Text('Delete'),
                              onPressed: () async {
                                final response = await Api.deleteCourse(data.id);
                                if(response.statusCode == 204) {
                                  courses.remove(data);
                                  reload();
                                }

                                },)),
                              DataCell(TextButton(child:Text('Edit'), onPressed: (){showEdit(data);},))
                        ]);
                      }).toList()
                  ),
                )
            ),
          )
        ],
      )
    )
    );
  }
}
