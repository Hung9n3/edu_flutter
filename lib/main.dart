import 'dart:convert';
import 'package:edusoft/Api/api.dart';
import 'package:edusoft/Auth/TokenHandle.dart';
import 'package:edusoft/UI/Admin/Admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Landing/Landing.dart';
import 'Navbar/NavBar.dart';
import 'package:url_strategy/url_strategy.dart';



void main() {
  setPathUrlStrategy();
  return runApp(MyApp());}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edusoft Web',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Montserrat"),
      home: MyHomePage(),

      routes: {
        '/Admin': (context) => Admin(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginHandle() async {
 var response1 = await Api.login(nameController.text, passwordController.text);
  final auth = jsonDecode(response1.body);
 if(response1.statusCode == 200)
   {
     TokenHandle.setString('token', auth["accessToken"]);
     var roles = List<String>.from(auth["roles"]);
     Navigator.pushNamed(context,'/Admin');
     print(TokenHandle.parseJwtPayLoad(auth["accessToken"])["unique_name"]);
     await TokenHandle.setStringList("role", roles);
     await TokenHandle.setString('idCard', TokenHandle.parseJwtPayLoad(auth["accessToken"])["unique_name"]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future.value(true);
      },
      child: Scaffold(
        body : FractionallySizedBox(
          heightFactor: 1.0,
          child:Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
                end:Alignment.centerRight,
                colors: [
                  Color.fromRGBO(195, 20, 50, 0.95),
                  Color.fromRGBO(36, 11, 54, 1.0)
                ]
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Navbar(
                  dialog: (){
                    showDialog(
                      context: context, barrierDismissible: false,
                      builder : (BuildContext context) {
                        return new AlertDialog(
                            actions: [
                              //Login Button
                              new TextButton(
                                child: Text('Login'),
                                onPressed: loginHandle
                              ),
                              new TextButton(
                                child: new Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          title: new Text('Sign in '),
                          content: new SingleChildScrollView(
                            child: new Container(

                              width: 300.0,
                              child: Column(
                                  children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                  child: TextField(
                                    autofocus: true,
                                      controller: nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'User Name'
                                    ),
                                  )
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                    child: TextField(
                                      obscureText: true,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Password'
                                      ),
                                    )
                                )
                              ]
                            )
                            )
                          )
                        );
                      }
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  child: Landing(),
                )
              ],
            ),
          )
        )
      )
      ),
    );
  }
}

