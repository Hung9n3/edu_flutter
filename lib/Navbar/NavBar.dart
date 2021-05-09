import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Navbar extends StatelessWidget {
  final Function dialog;
  Navbar ({this.dialog});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints){
          if (constraints.maxWidth > 1200) {
            return DesktopNavbar(
              dialog: dialog,
            );
          }
          else if (constraints.maxWidth > 1000 && constraints.maxWidth < 1200)
            {
              return DesktopNavbar(
                dialog: dialog,
              );
            }
          else {
            return MobileNavbar(
              dialog: dialog,
            );
          }
        }
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  final Function dialog;
  DesktopNavbar({this.dialog});
  @override
  Widget build(BuildContext context) {
    return
    Container(
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

        child: Padding(
      padding : const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                        fontSize: 40.0,
                        color: Colors.white
                    )
                ),
              ],//Children
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 30,),
              MaterialButton(
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                  onPressed:  dialog,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    )
    );
  }
}
class MobileNavbar extends StatelessWidget {
  final Function dialog;
  MobileNavbar ({this.dialog});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding : const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset("assets/images/iu_logo.png")
            ),
            Text(
              "International University",
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
                  MaterialButton(
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                    ),
                    onPressed:  dialog,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }
}
