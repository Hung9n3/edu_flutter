import 'dart:async';
import 'package:edusoft/Auth/TokenHandle.dart';
import 'package:edusoft/Model/User/UserGetById.dart';
import 'package:edusoft/UI/Admin/Page/Add.dart';
import 'package:edusoft/UI/Admin/Page/AddClasses.dart';
import 'package:edusoft/UI/Admin/Page/AddDepartment.dart';
import 'package:edusoft/UI/Admin/Page/AddStudent.dart';
import 'package:edusoft/UI/Admin/Page/AddTeacher.dart';
import 'package:edusoft/UI/Headbar/Headbar.dart';
import 'package:edusoft/UI/Admin/Page/Home.dart';
import 'package:edusoft/UI/Student/Page/Home.dart';
import 'package:edusoft/UI/Student/Page/RegisCourse.dart';
import 'package:edusoft/UI/Student/Page/Timetable.dart';
import 'package:edusoft/UI/Teacher/Page/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edusoft/Api/api.dart' show Api;



class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String role;
  Widget Teacher() {
    return WillPopScope(
        onWillPop: (){
          return Future.value(true);
        },
        child: Scaffold(
            body: Column(
                children: [
                  Headbar(Username),
                  Expanded(
                      child: NestedNavigator(navigationKey: _navigatorKey,
                      initialRoute: '/',
                      routes: {
                    '/' : (context) => TeacherH(),
                    '/timetable' : (context) => Timetable(),
                  }))

                ]
            )
        )

    );
  }
  Widget Student(){
    return WillPopScope(
        onWillPop: (){
          return Future.value(true);
        },
        child: Scaffold(
            body: Column(
                children: [
                  Headbar(Username),
                  Expanded(child: NestedNavigator(navigationKey: _navigatorKey, initialRoute: '/', routes: {
                    '/' : (context) => StudentH(),
                    '/applyCourse': (context) => RegisCourse(),
                    '/timetable' : (context) => Timetable(),
                  }))
                ]
            )
        )
    );
  }
  Widget Admin(){
    return WillPopScope(
        onWillPop: (){
          return Future.value(true);
        },
        child: Scaffold(
            body: Column(
                children: [
                  Headbar(Username),
                  Expanded(child: NestedNavigator(navigationKey: _navigatorKey,
                      initialRoute: '/',
                      routes: {
                    '/' : (context) => AdminH(),
                    '/Courses' : (context) => AddCourse(),
                    '/Departments' : (context) => AddDepartment(),
                    '/Classes' : (context) => AddClasses(),
                    '/Students' : (context) => Students(),
                    '/Teachers' : (context) => Teachers()
                  }))
                ]
            )
        )
    );
  }
  String Username = 'Admin';
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  Future init() async{
    String Role;
    List<String> role = await TokenHandle.getStringList('role');
    setState(() {
      this.role = role[0];
    });
      if(this.role != 'ADMIN') {
        if(this.role == 'STUDENT' ) {
          setState(() {
            Role = 'Students';
          });
        }
        if(this.role == 'TEACHER')
          {
            setState(() {
              Role = 'Teachers';
            });
          }
        UserGetById user = await Api.getUserinfo(Role,  TokenHandle.parseJwtPayLoad(await TokenHandle.getString('token'))["unique_name"]);
        setState(() {
          this.Username = user.fullName;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      if(role == 'student' || role == 'STUDENT') return Student();
      else if(role == 'teacher' ||role == 'TEACHER') return Teacher();
      else if(role == 'admin'|| role == 'ADMIN') return Admin();
      else return Scaffold(body: Container(child: Text('who are you'+ role + '???'),));
    });
  }


}
class NestedNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  final Map<String, WidgetBuilder> routes;

  NestedNavigator({
    @required this.navigationKey,
    @required this.initialRoute,
    @required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Navigator(
        key: navigationKey,
        initialRoute: initialRoute,
        onGenerateRoute: (RouteSettings routeSettings) {
          print(routeSettings.name);
          WidgetBuilder builder = routes[routeSettings.name];

          return MaterialPageRoute(
            builder: builder,
            settings: routeSettings,
          );
        },
      ),
      onWillPop: () {
        if(navigationKey.currentState.canPop()) {
          navigationKey.currentState.pop();
          return Future<bool>.value(false);
        }
        return Future<bool>.value(true);
      },
    );
  }
}


