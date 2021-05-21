import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Headbar extends StatefulWidget {
  final String Username;
  Headbar(this.Username);
  @override
  _HeadbarState createState() => _HeadbarState();
}

class _HeadbarState extends State<Headbar> {
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints){
          if (constraints.maxWidth > 1200) {
            return DesktopNavbar(widget.Username);
          }
          else if (constraints.maxWidth > 1100 && constraints.maxWidth < 1200)
          {
            return DesktopNavbar(widget.Username);
          }
          else {
            return MobileNavbar(widget.Username);
          }
        }
    );
  }
}

class DesktopNavbar extends StatefulWidget {
  String Username;
  DesktopNavbar(this.Username);

  @override
  _DesktopNavbarState createState() => _DesktopNavbarState();
}

class _DesktopNavbarState extends State<DesktopNavbar> {

  @override
  Widget build(BuildContext context) {
    return
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end:Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(90,92,106,1),
                    Color.fromRGBO(32,45,58,1)
                  ]
              )
          ),

          child: Padding(
            padding : const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Row(
                    children: [Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Image.asset("assets/images/iu_logo.png")
                    ),
                      Text(
                          "International University",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white
                          )
                      ),
                    ],//Children
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Text("Hello " + widget.Username,
                      style: TextStyle(color: Colors.white))
                    )
                  ],
                )
              ],
            ),
          )
      );
  }
}

class MobileNavbar extends StatefulWidget {
  String Username;
  MobileNavbar(this.Username);

  @override
  _MobileNavbarState createState() => _MobileNavbarState();
}

class _MobileNavbarState extends State<MobileNavbar> {
  @override
  Widget build(BuildContext context) {
    return  Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end:Alignment.centerRight,
                    colors: [
                      Color.fromRGBO(90,92,106,1),
                      Color.fromRGBO(32,45,58,1)
                    ]
                )
            ),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset("assets/images/iu_logo.png")
                ),
                Text(
                  "University",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 30,),
                        Text('Hello, ' + widget.Username,
                        style: TextStyle(color: Colors.white)),
                      ],
                    )
                )
              ],
            )
        );
  }
}


