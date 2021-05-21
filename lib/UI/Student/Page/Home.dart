import 'dart:async';
import 'package:edusoft/Auth/TokenHandle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double pad = 100;
class StudentH extends StatefulWidget {
  @override
  _StudentHState createState() => _StudentHState();
}

class _StudentHState extends State<StudentH> {
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
  Widget page(double pad, double width){
    return WillPopScope(
        onWillPop: (){
          return Future.value(true);
        },
        child: Container(
          width: width,
              padding : EdgeInsets.symmetric(vertical: 80.0,horizontal: 80.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: pad),
                        child: Column(
                          children: [
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.calendarAlt),
                              iconSize: 60,
                              tooltip: 'Apply Course',
                              onPressed: (){
                                Navigator.of(context).pushNamed('/applyCourse');
                              },
                            ),
                            Text("Apply Course")
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: pad),
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
                        padding: EdgeInsets.symmetric(horizontal: pad),
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
          )
    );
  }
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraint){
        pad = constraint.maxWidth/10;
        if(constraint.maxWidth >= 1200) return page(pad, constraint.biggest.width);
        if(constraint.maxWidth < 1200 && constraint.maxWidth > 700) {pad = constraint.maxWidth/15; return page(pad, constraint.biggest.width);}
        if(constraint.maxWidth <= 700 && constraint.maxWidth < 500) {pad = constraint.maxWidth/10; return page(pad, constraint.biggest.width);}
        else return page(pad = 10, constraint.biggest.width);
      }
    );
  }
}
// class Users {
//   String Name;
//   Users(this.Name);
// }
