import 'dart:async';
import 'package:edusoft/Auth/TokenHandle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TeacherH extends StatefulWidget {
  @override
  _TeacherHState createState() => _TeacherHState();
}

class _TeacherHState extends State<TeacherH> {
  String Role = 'role';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Init();
  }
  Future Init() async {
    List<String> role = await TokenHandle.getStringList('role');
    switch (role[0]) {
      case 'student' : setState(() {
        Role = 'Students';
      });
      print(Role);
      break;
      case 'teacher' : setState(() {
        Role = 'Teachers';
      });
      print(Role);
      break;
    }
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: (){
          return Future.value(true);
        },
        child: Container(
          child: Container(
            padding : EdgeInsets.symmetric(vertical: 80.0,horizontal: 80.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        child: Column(
                          children: [
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.calendarAlt),
                              iconSize: 60,
                              tooltip: 'Timetable',
                              onPressed: (){
                                Navigator.of(context).pushNamed('/timetable');
                              },
                            ),
                            Text("Timetable")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:0),
                      child: Container(
                        child: Column(
                          children: [
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.clipboardList),
                              iconSize: 60,
                              tooltip: 'About You',
                              onPressed: (){
                                Navigator.pushNamed(context, '/Info');
                              },
                            ),
                            Text(Role)
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
            )
        ),)
    );
  }
}
// class Users {
//   String Name;
//   Users(this.Name);
// }
