// import 'package:flutter/material.dart';
//
// class Function {
//   final Function function;
//   Function(this.function);
//   AlertDialog dialog (Function function){
//     TextEditingController nameController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     function = this.function;
//   showDialog(
//   context: context, barrierDismissible: false,
//   builder : (BuildContext context) {
//   return new AlertDialog(
//   actions: [
//   //Login Button
//   new MaterialButton(
//   child: Text('Login'),
//   onPressed: function
//   ),
//   new TextButton(
//   child: new Text('Close'),
//   onPressed: () {
//   Navigator.of(context).pop();
//   },
//   ),
//   ],
//   title: new Text('Sign in '),
//   content: new SingleChildScrollView(
//   child: new Container(
//
//   width: 300.0,
//   child: Column(
//   children: [
//   Container(
//   padding: EdgeInsets.all(5),
//   child: TextField(
//   autofocus: true,
//   controller: nameController,
//   decoration: InputDecoration(
//   border: OutlineInputBorder(),
//   labelText: 'User Name'
//   ),
//   )
//   ),
//   Container(
//   padding: EdgeInsets.all(5),
//   child: TextField(
//   obscureText: true,
//   controller: passwordController,
//   decoration: InputDecoration(
//   border: OutlineInputBorder(),
//   labelText: 'Password'
//   ),
//   )
//   )
//   ]
//   )
//   )
//   )
//   );
//   }
//   );}
// }