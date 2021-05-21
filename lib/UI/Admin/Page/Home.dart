import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double pad = 100;
class AdminH extends StatefulWidget {
  @override
  _AdminHState createState() => _AdminHState();
}

class _AdminHState extends State<AdminH> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget page(double pad, double width){
    return WillPopScope(
        onWillPop: (){
          return Future.value(true);
        },
      child:
          Container(
              child:
              Column(
                children: [
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
