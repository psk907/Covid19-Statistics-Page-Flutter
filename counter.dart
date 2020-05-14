
import 'package:covid19/models/constant.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  final int delta;
  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
    this.delta=0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color dynamiciconcolor = (!isDarkMode) ? Colors.black : Colors.white;
    Color dynamicuicolor =
        (!isDarkMode) ? new Color(0xfff8faf8) : Color.fromRGBO(25, 25, 25, 1.0);
        Color dynamicbgcolor =
        (!isDarkMode) ? Colors.grey[200] : Colors.black;
    return Card(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: dynamicuicolor,
      elevation: 0.5,
      child:Padding(
        padding:EdgeInsets.only(top: 10),
    child:Column(
      children: <Widget>[
        Container(
          //padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "$number",
          style: TextStyle(
            fontSize: 24,
            color: color,
          ),
        ),
        Text(
          "+$delta",
          style: TextStyle(
            fontSize: 14,
            color: color,
          ),
        ),
        SizedBox(height: 1),
        Text(title, style: kSubTextStyle),
        
      ],
    )));
  }
}

