import 'dart:convert';
import 'package:edusoft/Auth/TokenHandle.dart';
import 'package:edusoft/Model/Class/ClassGet.dart';
import 'package:edusoft/Model/User/User.dart';
import 'package:edusoft/Model/User/UserGet.dart';
import 'package:edusoft/Model/User/UserGetById.dart';
import 'package:edusoft/Model/WeekDay/WeekDay.dart';
import 'package:flutter/material.dart';
import 'package:edusoft/Api/api.dart';


class RegisCourse extends StatefulWidget {
  @override
  _RegisCourseState createState() => _RegisCourseState();
}

class _RegisCourseState extends State<RegisCourse> {
  List<ClassGet> classGets = [];
  IconData iconData = Icons.delete;
  List<ClassGet> selectedClasses = [];
  List<ClassGet> Regis = [];
  List<UserGet> teacher = [];
  UserGetById userGetById ;
  UserPost userPost = UserPost('',[], 0, 'fullName', true, '', 'email', 'phoneNumber', 'address', false);
  String id ;
  Future getCourse() async {
    final classGets = await Api.getClass();
    final user = await Api.getUserinfo('Students', TokenHandle.parseJwtPayLoad(await TokenHandle.getString('token'))["unique_name"]);
    final department = await Api.getDepartment();
    final teacher = await Api.getAllUserInfo('Students');
    setState(() {
      this.classGets = classGets;
      this.teacher = teacher;
    });
    setState(() {

      this.userGetById = user;
      this.Regis = userGetById.classes;
      this.selectedClasses = this.Regis;
      userPost.idCard = userGetById.idCard;
      userPost.fullName = userGetById.fullName;
      userPost.gender = userGetById.gender;
      userPost.phoneNumber = userGetById.phoneNumber;
      userPost.address = userGetById.address;
      userPost.email = userGetById.email;
      userPost.birthdate = userGetById.birthdate;
      userPost.isHead = userGetById.isHead;
      print(userGetById.isHead);
      for(var d in department)
        {
          if(userGetById.department == d.name)
            {
              userPost.departmentId = d.Id;
              break;
            }
        }
    });
    return  classGets;
  }
  void reload(){
    Navigator.popAndPushNamed(context, '/applyCourse');
  }
  @override
  void initState()
  {
    super.initState();
    init();
  }
Future init() async {
    final classGets = await getCourse();
    setState(() {
      this.classGets = classGets;
    });
}
  @override
  Widget build(BuildContext context) {
      return Container(
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
                 child: SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                     child: Column(
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
                                Container(
                                  height: 300,
                                  child: SingleChildScrollView(
                                    //Render api data into table
                                    child: DataTable(
                                        onSelectAll: (isSelectedAll){
                                          setState(() {
                                            selectedClasses = isSelectedAll ? classGets : [];
                                          });
                                        },
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
                                        ],
                                        rows: classGets.map((data) {
                                          String day = days[data.day-1].Day;
                                          return DataRow(
                                            //enable selected row
                                              selected: selectedClasses.any((element) => element.classCode == data.classCode),
                                              onSelectChanged: (isSelected) {
                                                setState(() {
                                                  final isAdding = isSelected;
                                                  if(isAdding == true)
                                                    {
                                                      selectedClasses.add(data);}
                                                  else
                                                       selectedClasses.remove(data);
                                                });
                                              },
                                              cells: [
                                                DataCell(Text(data.classCode)),
                                                DataCell(Text(data.course)),
                                                DataCell(Text(data.department)),
                                                DataCell(Text(data.teacher)),
                                                DataCell(Text(data.periods.toString())),
                                                DataCell(Text(data.startPeriods.toString())),
                                                DataCell(Text(day)),
                                              ]
                                          );
                                        }).toList()
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,50.0,0,0),
                                  child: Container(
                                    child: DataTable(
                                      columns: [
                                        DataColumn(label: Text('Id')),
                                        DataColumn(label: Text('Course')),
                                        DataColumn(label: Text('Department')),
                                        DataColumn(label: Text('Teacher')),
                                        DataColumn(label: Text('Credits')),
                                        DataColumn(label: Text('Start Period')),
                                        DataColumn(label: Text('Day in week')),
                                        //Delete
                                        DataColumn(label: Text(''))
                                      ],
                                       rows: selectedClasses.map((data) {
                                         String day = days[data.day - 1].Day;
                                         return DataRow(cells: [
                                           DataCell(Text(data.classCode)),
                                           DataCell(Text(data.course)),
                                           DataCell(Text(data.department)),
                                           DataCell(Text(data.teacher)),
                                           DataCell(Text(data.periods.toString())),
                                           DataCell(Text(data.startPeriods.toString())),
                                           DataCell(Text(day)),
                                           DataCell(IconButton(
                                             icon: Icon(iconData),
                                             onPressed: () {
                                               setState(() {
                                                 selectedClasses.remove(data);
                                               });
                                             },
                                           ))
                                         ]);
                                       }).toList()
                                    )
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [TextButton(onPressed: () async{
                                    List<int> classes = [];
                                    setState(() {
                                      for(var s in selectedClasses)
                                        {
                                          classes.add(s.id);
                                        }
                                      this.userPost.classes = classes;
                                    });
                                    final response = await Api.updateUserinfo('Students', userPost.idCard, jsonEncode(userPost.toJson()));
                                    print(userPost.toJson());
                                    reload();
                                  }, child: Text('Save'))],
                                )
                              ],
                            )
              ),
                 ),
               ),
      );

    }
}
