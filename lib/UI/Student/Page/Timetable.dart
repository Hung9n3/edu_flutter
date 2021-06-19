import 'package:edusoft/Api/api.dart';
import 'package:edusoft/Auth/TokenHandle.dart';
import 'package:edusoft/Model/Class/ClassGet.dart';
import 'package:edusoft/Model/User/UserGetById.dart';
import 'package:edusoft/Model/WeekDay/WeekDay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class Timetable extends StatefulWidget {
  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  String Role;
  List<ClassGet> classes = [];
  UserGetById userGet;
  void showDetail(ClassGet classGet){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        actions: [
          TextButton(onPressed: (){Navigator.of(context).pop();}, child:Text('close') )
        ],
        content: Container(
          padding: EdgeInsets.all(5.0),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Course')),
              DataColumn(label: Text('Room')),
              DataColumn(label: Text('Teacher'))
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(classGet.course)),
                DataCell(Text(classGet.room)),
                DataCell(Text(classGet.teacher))
              ])
            ],
          )
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
  Future Init() async {
    final role = await TokenHandle.getStringList('role');
    switch (role[0]) {
      case 'STUDENT' : setState(() {
        this.Role = 'Students';
      });
      print(Role);
      break;
      case 'TEACHER' : setState(() {
        this.Role = 'Teachers';
      });
      print(this.Role);
      break;
    }
    final user = await Api.getUserinfo(this.Role, TokenHandle.parseJwtPayLoad(await TokenHandle.getString('token'))["unique_name"]);
    setState(() {
      this.userGet = user;
      this.classes = this.userGet.classes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(30),
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
                        onTap: (){
                          showDetail(c);
                        },
                        // decoration: BoxDecoration(border: Border(
                        //   top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //   left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                        //   right: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                        //   bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        // )),
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
            Container(
              padding: EdgeInsets.all(30),
              child: IconButton(icon: Icon(Icons.arrow_back_ios),
                onPressed: Navigator.of(context).pop),),]
    );
  }
}
