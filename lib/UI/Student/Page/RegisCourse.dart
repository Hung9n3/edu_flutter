import 'dart:convert';
import 'package:edusoft/Model/Class/ClassGet.dart';
import 'package:edusoft/Model/Course/Courses.dart';
import 'package:flutter/material.dart';
import 'package:edusoft/Api/api.dart' show Api;


class RegisCourse extends StatefulWidget {
  @override
  _RegisCourseState createState() => _RegisCourseState();
}

class _RegisCourseState extends State<RegisCourse> {
  List<ClassGet> classGets = [];
  List<ClassGet> selectedClasses = [];
  List<ClassGet> Regis = [];
  Future getCourse() async {
    final classGets = await Api.getClass();
    setState(() {
      this.classGets = classGets;
    });
    final Regis = await Api.getStudentInfo('Students');
    setState(() {
      this.Regis = Regis.classes;
      this.selectedClasses = this.Regis;
    });
    return  classGets;
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
      return  Scaffold(
          appBar: AppBar(
            title: Text('Flutter ListView'),
          ),
          body:
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 100),
               child: Column(
                        children: [
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
                                        label: Text('Name')
                                    ),
                                    DataColumn(label: Text('Department'))
                                  ],
                                  rows: classGets.map((data) {
                                    var index = data.classCode;
                                    return DataRow(
                                      //enable selected row
                                        selected: selectedClasses.any((element) => element.classCode == data.classCode),
                                        onSelectChanged: (isSelected) {
                                          setState(() {
                                            final isAdding = isSelected;
                                            if(isAdding == true)
                                              {print(isAdding);
                                                selectedClasses.add(data);}
                                            else
                                                 selectedClasses.remove(data);
                                          });
                                        },
                                        cells: [
                                          DataCell(Text("$index")),
                                          DataCell(Text(data.room)),
                                          DataCell(Text(data.periods.toString()))
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
                                DataColumn(
                                  label: Text('Id')
                                ),
                                DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Department'))
                                ],
                                 rows: selectedClasses.map((data) {
                                   // print(data.classCode);
                                   return DataRow(cells: [
                                     DataCell(Text(data.classCode)),
                                   DataCell(Text(data.room)),
                                     DataCell(Text(data.periods.toString()))
                                   ]);
                                 }).toList()
                              )
                            ),
                          )
                        ],
                      )
            ),
      );
    }
}
