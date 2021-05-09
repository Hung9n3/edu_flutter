import 'package:edusoft/Api/api.dart';
import 'package:edusoft/Model/Department/DepartmentGet.dart';
import 'package:edusoft/Model/Department/DepartmentPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDepartment extends StatefulWidget {
  @override
  _AddDepartmentState createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  TextEditingController name = TextEditingController()
;  List<DepartmentGet> departments = [];
  Future Init() async {
    final departments = await Api.getDepartment();
    setState(() {
      this.departments = departments;
    });
  }
  Future createDepartment() async {
    String shortName = getInitials(name.text);
    print(shortName);
    DepartmentPost departmentPost = DepartmentPost(name.text, shortName);
    print(departmentPost);
    final response = await Api.createDepartment(departmentPost);
    return response;
  }
  String getInitials(word) {
    List<String> names = word.split(" ");
    String initials = "";
    int numWords = 2;

    if(numWords < names.length) {
      numWords = names.length;
    }
    for(var i = 0; i < numWords; i++){
      initials += '${names[i][0]}';
    }
    return initials;
  }
  Widget showEdit(DepartmentGet departmentGet){
    showDialog(context: context, builder: (BuildContext context) {
      TextEditingController name = TextEditingController(text: departmentGet.name);
      return AlertDialog(
        actions: [
          TextButton(
            child: Text('Save'),
            onPressed: () async {
                final response =  await Api.updateDepartment(DepartmentPost(name.text, getInitials(name.text)), departmentGet.Id.toString());
                if(response.statusCode == 204) Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text('Close'),
              onPressed:(){
                Navigator.of(context).pop();
              }
          )
        ],
        title: Text('Edit Departmnent'),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: 400,
                  width: 350,
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: name,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name'
                                ),
                              )
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
  void showAdd (){

    showDialog(context: context, builder: (BuildContext context) {

      return AlertDialog(
        actions: [
          TextButton(
            child: Text('Save'),
            onPressed: (){
              setState(() async {
                final response = await createDepartment();
                print(response.statusCode);
                if(response.statusCode == 201) Navigator.of(context).pop();
              });
            }
          ),
          TextButton(
              child: Text('Close'),
              onPressed:(){
                Navigator.of(context).pop();
              }
          )
        ],
        title: Text('Edit Department'),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  width: 350,
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: name,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name'
                                ),
                              )
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Departments'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(0),
              child: TextButton(
                child: Text('Add new department'),
                onPressed: showAdd,
              )
            ),
            Container(
              padding: EdgeInsets.all(0),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Id')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Short Name')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: departments.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(data.Id.toString())),
                    DataCell(Text(data.name)),
                    DataCell(Text(data.shortName)),
                    DataCell(TextButton(
                      child: Text('Delete'),
                      onPressed: (){
                        setState(() async {
                          final response = await Api.deleteDepartment(data.Id.toString());
                          if(response.statusCode != 204) print('error');
                          else departments.remove(data);
                        });
                      },
                    )),
                    DataCell(TextButton(
                      child: Text('Edit'),
                      onPressed: (){
                        setState(() {
                          showEdit(data);
                        });
                      },
                    )),
                  ]);
                }).toList(),
              )
            )
          ],
        ),
      ),
    );
  }
}
