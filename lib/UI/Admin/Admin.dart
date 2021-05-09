
import 'package:edusoft/UI/Headbar/Headbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edusoft/Api/api.dart' show Api;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  //Get User info


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
        child: Scaffold(
          body:
          Container(
              child:
              Column(
                children: [
                  Headbar('Admin'),
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
                                      tooltip: 'Classes',
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/Classes');
                                      },
                                    ),
                                    Text('Classes')
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
                                        tooltip: 'Departments',
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/Departments');
                                        },
                                      ),
                                      Text("Departments")
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
                                        tooltip: 'Courses',
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/Courses');
                                        },
                                      ),
                                      Text("Courses")
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
                                        tooltip: 'Students',
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/Students');
                                        },
                                      ),
                                      Text("Students"),
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
                                        tooltip: 'Teachers',
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/Teachers');
                                        },
                                      ),
                                      Text("Teachers"),
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
