import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../blank.dart';

void main() => runApp(
  MaterialApp(
    home: Landing(),
    routes: {
      '/blank': (context) => Blank(),
    },
  )
);

class Landing extends StatelessWidget {
  List<Widget> pageChildren(double width) {
    return <Widget> [
      Container(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Student",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "We have taken each and every project handed over to us as a challenge, "
                        "which has helped us achieve a high project success rate.",
                    style: TextStyle(
                        color:Colors.white
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: (){},
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                    child: Text(
                        "Visit school page",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0
                        )
                    ),
                  ),
                )
              ],
            ),
          )
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Image.asset("assets/images/lp_image.png",
          width: width,
        ),
      )
    ];
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints)
        {
          if(constraints.maxWidth > 800) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pageChildren(constraints.biggest.width/2),
            );
          } else {
            return Column(
                children: pageChildren(constraints.biggest.width));
          }
        }
    );
  }
}



