import 'dart:convert';

import 'package:edusoft/Api/api.dart';
import 'package:edusoft/Model/Department/DepartmentGet.dart';
import 'package:edusoft/Model/User/User.dart';
import 'package:edusoft/Model/User/UserGet.dart';
import 'package:edusoft/Model/User/UserGetById.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Teachers extends StatefulWidget {
  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  int departmentId;
  TextEditingController fullName = TextEditingController();
  bool gender = false;
  TextEditingController date = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController year = TextEditingController();
  String birthdate;
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  List<DepartmentGet> departments = [];
  List<UserGet> Teachers = [];
  Future init() async {
    final Teachers = await Api.getAllUserInfo('Teachers');
    setState(() {
      this.Teachers = Teachers;
    });
    final departments = await Api.getDepartment();
    setState(() {
      this.departments = departments;
    });
  }
  Future createStudent() async {
    birthdate = date.text + '/' + month.text +'/' + year.text;
    UserPost userPost = UserPost('',null,departmentId, fullName.text, gender, birthdate, email.text, phoneNumber.text, address.text, null);
    print(userPost.toJson());
    final response = await Api.createUser('Teachers', userPost);
    print(response.statusCode);
    return response;
  }
  void showAdd()  {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            actions: [
              TextButton(
                  child: Text('Save'),
                  onPressed: () async {
                    final response = await createStudent();
                    if(response.statusCode == 201) Navigator.of(context).pop();
                  }
              ),
              TextButton(
                child: Text('Close'),
                onPressed: (){
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                      height: 500,
                      width: 350,
                      child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: departmentId,
                                    hint: Text('Choose a department'),
                                    onChanged: (int newValue){
                                      setState((){
                                        departmentId = newValue;
                                      });
                                    },
                                    items: departments.map((data) => DropdownMenuItem(value: data.Id, child: Text(data.name))).toList(),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                      children: [
                                        Text('Male'),
                                        Checkbox(
                                          value: gender,
                                          onChanged: (bool value){
                                            setState((){
                                              gender = !gender;
                                            });
                                          },
                                        ),]
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: fullName,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Full name'
                                    ),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: address,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Address'
                                    ),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: phoneNumber,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Phone number'
                                    ),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: email,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Email'
                                    ),
                                  )
                              ),
                              Row(children: [Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text('Birthday')),]),
                              Container(
                                child:  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        width: 100,
                                        child: TextField(
                                          controller: date,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Date'
                                          ),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          width: 100,
                                          child: TextField(
                                            controller: month,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'month'
                                            ),
                                          )
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          width: 100,
                                          child: TextField(
                                            controller: year,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'year'
                                            ),
                                          )
                                      )
                                    ]
                                ),
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
  void showEdit(UserGet userGet) async {
    print('a');
    UserGetById userGetById = await Api.getUserinfo('Teachers', userGet.idCard);
    List<int> classes = [];
    userGetById.classes.map((e) => classes.add(e.id));
    int departmentId ;
    TextEditingController fullName = TextEditingController(text: userGet.fullName);
    bool gender = userGet.gender;
    TextEditingController birthday = TextEditingController(text: userGet.birthdate);
    TextEditingController email = TextEditingController(text: userGet.email);
    TextEditingController address = TextEditingController(text: userGet.address);
    TextEditingController phoneNumber = TextEditingController(text: userGet.phoneNumber);
    for(var d in departments)
    {
      if(d.name == userGet.department) {
        departmentId = d.Id;
      }
    }
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            actions: [
              TextButton(
                  child: Text('Save'),
                  onPressed: () async {
                    UserPost user = UserPost('',classes,departmentId, fullName.text, gender, birthday.text, email.text, phoneNumber.text, address.text, userGet.isHead);
                    final response = await Api.updateUserinfo('Teachers', userGet.idCard, jsonEncode(user.toJson()));
                    print(response.statusCode);
                    if(response.statusCode == 200) Navigator.of(context).pop();
                  }
              ),
              TextButton(
                child: Text('Close'),
                onPressed: (){
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                      height: 500,
                      width: 350,
                      child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: departmentId,
                                    hint: Text('Choose a department'),
                                    onChanged: (int newValue){
                                      setState((){
                                        departmentId = newValue;
                                      });
                                    },
                                    items: departments.map((data) => DropdownMenuItem(value: data.Id, child: Text(data.name))).toList(),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                      children: [
                                        Text('Male'),
                                        Checkbox(
                                          value: gender,
                                          onChanged: (bool value){
                                            setState((){
                                              gender = !gender;
                                            });
                                          },
                                        ),]
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: fullName,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Full name'
                                    ),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: address,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Address'
                                    ),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: phoneNumber,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Phone number'
                                    ),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: email,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Email'
                                    ),
                                  )
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    controller: birthday,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Birthday'
                                    ),
                                  )
                              ),
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
    init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
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
                  child: TextButton(
                    child: Text('Add new student'),
                    onPressed: (){
                      showAdd();
                    },
                  ),
                ),
                Container(
                  height: 800,
                  child: DataTable(
                      showBottomBorder: true,
                      columns:
                      [
                        DataColumn(label: Text('Id')),
                        DataColumn(label: Text('Full name')),
                        DataColumn(label: Text('Birthdate')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Male')),
                        DataColumn(label: Text('Phone')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Department')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                      ], rows: Teachers.map((data) => DataRow(cells: [
                    DataCell(Text(data.idCard)),
                    DataCell(
                      Text(data.fullName),),
                    DataCell(Text(data.birthdate)),
                    DataCell(Text(data.address)),
                    DataCell(Text(data.gender.toString())),
                    DataCell(Text(data.phoneNumber)),
                    DataCell(Text(data.email)),
                    DataCell(Text(data.department)),
                    DataCell(Text(''),
                        showEditIcon: true,
                        onTap: (){
                          showEdit(data);
                        }),
                    DataCell(IconButton(icon: Icon(FontAwesomeIcons.trashAlt),
                      onPressed: () async {
                        final response = await Api.deleteAny('Teachers', data.idCard);
                        if(response.statusCode == 204) Navigator.popAndPushNamed(context, '/Teacher');
                      },))
                  ])).toList() ),
                )
              ],
            ),
          )
      ),
    );
  }
}
