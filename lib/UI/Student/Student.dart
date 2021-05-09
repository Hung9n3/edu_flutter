import 'dart:convert';
import 'dart:async';
import 'package:edusoft/Model/User/StudentGet.dart';
import 'package:edusoft/UI/Headbar/Headbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edusoft/Api/api.dart' show Api;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:html' show window;
import 'package:shared_preferences/shared_preferences.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  String Username = 'username';
   //Get User info
  Future<StudentGet> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("token: " + preferences.get("token"));
    print(preferences.getStringList("role"));
    var data = await Api.getStudentInfo('Students');
    Username = data.fullName;
    return data;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  Future init() async{
    await getUserInfo();
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: (){
          return Future.value(true);
        },
        child: Scaffold(
          body:
             Container(
              child:
                  Column(
                children: [
                    Headbar(Username),
                    Container(
                      width: 900,
                      padding : EdgeInsets.symmetric(vertical: 80.0,horizontal: 80.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Container(
                                child: Column(
                                  children: [
                                    IconButton(
                                        icon: FaIcon(FontAwesomeIcons.clipboardCheck),
                                      iconSize: 60,
                                      tooltip: 'Course Registration',
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/RegisCourse');
                                      },
                                    ),
                                    Text('Courses Registration')
                                  ],
                                ),
                              ),
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
                                          Navigator.pushNamed(context, '/Timetable');
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
                                      Text("User Info")
                                    ],
                                  ),
                                ),
                              ),
                            ]
                        ),
                      )
                    )

                  ],
              )
        ),
          )

    );
  }
}
// class Users {
//   String Name;
//   Users(this.Name);
// }
