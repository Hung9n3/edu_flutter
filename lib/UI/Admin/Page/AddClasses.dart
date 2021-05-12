import 'dart:html';

import 'package:edusoft/Model/Class/ClassGet.dart';
import 'package:edusoft/Model/Class/ClassPost.dart';
import 'package:edusoft/Model/Course/Courses.dart';
import 'package:edusoft/Model/User/UserGet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edusoft/Model/WeekDay/WeekDay.dart' show days;
import 'package:edusoft/Api/api.dart' show Api;

class AddClasses extends StatefulWidget {
  @override
  _AddClassesState createState() => _AddClassesState();
}

class _AddClassesState extends State<AddClasses> {
   String courseCode;
   String teacherIdCard;
   TextEditingController room = TextEditingController();
   int day;
   TextEditingController startPeriods = TextEditingController();
   TextEditingController periods = TextEditingController();
   TextEditingController slot = TextEditingController();
  List<UserGet> teachers = [];
  List<Course> courses = [];
  List<ClassGet> classes = [];
  Future Init() async {
    final classes = await Api.getClass();
    setState(() {
      this.classes = classes;
    });
      final courses = await Api.getAllCourse();
      this.courses = courses;
      final teachers = await Api.getAllUserInfo('Teachers');
      this.teachers = teachers;
  }
  void createClasses() async {
    ClassPost classPost = ClassPost(courseCode, teacherIdCard, room.text, day, startPeriods.text, slot.text, periods.text);
    print(classPost.toJson());
    var response = await Api.createClasses(classPost);
    print(response.statusCode);
    if( response.statusCode == 201)
      Navigator.popAndPushNamed(context, '/Classes');
    else print(response.body["errors"]);
    return response;
  }
   void reload() {
     Navigator.pushReplacement(
         context,
         MaterialPageRoute(
             builder: (BuildContext context) => super.widget));}
   
  Widget showEdit(ClassGet classGet){
    showDialog(context: context, builder: (BuildContext context) {
      for(var t in teachers)
        {
          for(var c in courses)
            {
              if (classGet.teacher == t.fullName && classGet.course == c.name) {teacherIdCard = t.idCard;
              courseCode = c.courseCode;
              break;}
            }
        }
      day = classGet.day;
      TextEditingController room = TextEditingController(text: classGet.room);
      TextEditingController startPeriods = TextEditingController(text: classGet.startPeriods.toString());
      TextEditingController periods = TextEditingController(text: classGet.periods.toString());
      TextEditingController slot = TextEditingController(text: classGet.slot.toString());
      return AlertDialog(
        actions: [
          TextButton(
            child: Text('Save'),
            onPressed: (){
              ClassPost classPost = ClassPost(courseCode, teacherIdCard, room.text, day, startPeriods.text, slot.text, periods.text);
            },
          ),
          TextButton(
            child: Text('Close'),
            onPressed:(){
              Navigator.of(context).pop();
            }
          )
        ],
        title: Text('Edit Class'),
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
            child: Text(classGet.course)
            ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Choose a course'),
                      value: teacherIdCard,
                      elevation: 16,
                      onChanged: (String newValue){
                        setState(() {
                          teacherIdCard = newValue;
                          print(teacherIdCard);
                        });
                      },
                      items: teachers.map((data) {

                        return DropdownMenuItem(
                            value: data.idCard,
                            child: Text(data.fullName));
                      }).toList(),
                    )
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Choose a course'),
                      value: day,
                      elevation: 16,
                      onChanged: (int newValue){
                        setState(() {
                          day = newValue;
                          print(day);
                        });
                      },
                      items: days.map((data) {

                        return DropdownMenuItem(
                            value: data.id,
                            child: Text(data.Day));
                      }).toList(),
                    )
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: room,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'room'
                    ),
                  )
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: slot,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'slot'
                      ),
                    )
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: periods,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'periods'
                      ),
                    )
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: startPeriods,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'startPeriods'
                      ),
                    )
                )
              ],
            )
          )
        );
      }
        ),
      );
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Init();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Classes'),
        ),
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0),
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0),
                      child: Container(
                        child:
                        TextButton(onPressed: (){
                          showDialog(
                              context: context, barrierDismissible: false,
                              builder : (BuildContext context) {
                                return new AlertDialog(
                                    actions: [
                                      //Login Button
                                      new TextButton(
                                          child: Text('Submit'),
                                          onPressed: createClasses
                                      ),
                                      new TextButton(
                                        child: new Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                    title: new Text('Add Class'),
                                    content:  StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return  Container(
                                              height: 450,
                                              width: 350.0,
                                              child: Container(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.all(5),
                                                            child: DropdownButton(
                                                              isExpanded: true,
                                                              hint: Text('Choose a course'),
                                                              value: courseCode,
                                                              elevation: 16,
                                                              onChanged: (String newValue){
                                                                setState(() {
                                                                  courseCode = newValue;
                                                                  print(courseCode);
                                                                });
                                                              },
                                                              items: courses.map((data) {

                                                                return DropdownMenuItem(
                                                                    value: data.courseCode,
                                                                    child: Text(data.name));
                                                              }).toList(),
                                                            )
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.all(5),
                                                            child: DropdownButton(
                                                              isExpanded: true,
                                                              hint: Text('Choose a teacher'),
                                                              value: teacherIdCard,
                                                              elevation: 16,
                                                              onChanged: (String newValue){
                                                                setState(() {
                                                                  teacherIdCard = newValue;
                                                                  print(teacherIdCard);
                                                                });
                                                              },
                                                              items: teachers.map((data) {

                                                                return DropdownMenuItem(
                                                                    value: data.idCard,
                                                                    child: Text(data.fullName));
                                                              }).toList(),
                                                            )
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.all(5),
                                                            child: DropdownButton(
                                                              isExpanded: true,
                                                              hint: Text('Choose a day'),
                                                              value: day,
                                                              elevation: 16,
                                                              onChanged: (int newValue){
                                                                setState(() {
                                                                  day = newValue;
                                                                  print(day);
                                                                });
                                                              },
                                                              items: days.map((data) {

                                                                return DropdownMenuItem(
                                                                    value: data.id,
                                                                    child: Text(data.Day));
                                                              }).toList(),
                                                            )
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.all(5),
                                                            child: TextField(
                                                              autofocus: true,
                                                              controller: room,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'Room'
                                                              ),
                                                            )
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.all(5),
                                                            child: TextField(
                                                              controller: slot,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'Slot'
                                                              ),
                                                            )
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.all(5),
                                                            child: TextField(
                                                              autofocus: true,
                                                              controller: startPeriods,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'startPeriods'
                                                              ),
                                                            )
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.all(5),
                                                            child: TextField(
                                                              autofocus: true,
                                                              controller: periods,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'periods'
                                                              ),
                                                            )
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              )
                                          );
                                      },
                                    )
                                );
                              }
                          );
                        },
                            child: Text('Add New Class',
                            style: TextStyle(
                              fontSize: 16
                            )),
                        )
                      ),
                    ),

                     Container(
                       height: 600,
                       child: SingleChildScrollView(
                          //Render api data into table
                          child: DataTable(
                              columns: [
                                DataColumn(label: Text('Id')),
                                DataColumn(
                                    label: Text('Course')
                                ),
                                DataColumn(label: Text('Department')),
                                DataColumn(label: Text('Teacher')),
                                DataColumn(label: Text('Credits')),
                                DataColumn(label: Text('Start Period')),
                                DataColumn(label: Text('Day in week')),
                                DataColumn(label: Text('')),
                                DataColumn(label: Text(''))
                              ],
                              rows: classes.map((data) {
                                String day = days[data.day].Day;
                                return DataRow(
                                    cells: [
                                      DataCell(Text(data.classCode)),
                                      DataCell(Text(data.course)),
                                      DataCell(Text(data.department)),
                                      DataCell(Text(data.teacher)),
                                      DataCell(Text(data.periods.toString())),
                                      DataCell(Text(data.startPeriods.toString())),
                                      DataCell(Text(day)),
                                      DataCell(IconButton(
                                        icon:Icon(Icons.delete),
                                        onPressed: () async {
                                          final response = await Api.deleteAny('Classes', data.classCode);
                                          if(response.statusCode == 204) Navigator.popAndPushNamed(context, '/Classes');
                                        },
                                      )),
                                      DataCell(IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: (){
                                              showEdit(data);
                                        },
                                      ))
                                    ]
                                );
                              }).toList()
                          ),
                        ),
                     ),
                  ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
