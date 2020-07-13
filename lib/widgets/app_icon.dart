import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Row(
              children: <Widget>[
               Icon(Icons.account_circle,
               color: Colors.blueAccent,
               size: 40.0,),
                Text("Control tareas",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700
                ),
                )
              ],
            );

  }
}