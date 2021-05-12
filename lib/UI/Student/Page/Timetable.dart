import 'package:edusoft/Api/api.dart';
import 'package:edusoft/Auth/TokenHandle.dart';
import 'package:edusoft/Model/Class/ClassGet.dart';
import 'package:edusoft/Model/User/UserGet.dart';
import 'package:edusoft/Model/User/UserGetById.dart';
import 'package:edusoft/Model/WeekDay/WeekDay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class Timetable extends StatefulWidget {
  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  List<ClassGet> classes = [];
  UserGetById userGet;
  ClassGet c;
  double startT = 8 ;
  int startH;
  var startM;
  double endT;
  int endH;
  var endM;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Init();
  }
  Future Init() async {
    final user = await Api.getUserinfo('Students', TokenHandle.parseJwtPayLoad(await TokenHandle.getString('token'))["unique_name"]);
    setState(() {
      this.userGet = user;
      this.classes = this.userGet.classes;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Time table'),
        ),
        body: Center(
          child: Container(
            child: TimetableView(
              laneEventsList: days.map((e) => LaneEvents(
                lane: Lane(name: e.Day),
                events: classes.map((c) {
                  if(c.day == e.id)
                    {
                      double startT;
                      if(c.startPeriods == 1){
                         startT = 8 ;
                      }
                      else startT = 8 + ((c.startPeriods )*0.75);
                      int startH = startT.toInt();
                      var startM = (startT - startH.toDouble())*60;
                      double endT = startT + c.periods*0.75;
                      int endH = endT.toInt();
                      var endM = (endT - endH.toDouble())*60;
                      return TableEvent(
                        decoration: BoxDecoration(border: Border(
                          top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                          left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                          right: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                          bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        )),
                          title: c.course,
                          start: TableEventTime(
                          hour: startH,
                          minute: startM.toInt()),
                          end: TableEventTime(
                            hour: endH,
                            minute: endM.toInt(),
                          ));
                    }
                  else return TableEvent(title: '', start: TableEventTime(hour: 0, minute: 0), end: TableEventTime(hour: 0,minute: 1));
                }).toList()
              )).toList(),
            ),
          ),
        ),
      )
    );
  }
}
