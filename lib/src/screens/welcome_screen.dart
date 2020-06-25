import 'package:control_tareas_app/src/widgets/app_button.dart';
import 'package:control_tareas_app/src/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget{

  //se indica la ruta de inicio
  static const String routeName = '';

  WelcomeScreen({Key key}) : super(key:key);

  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //import boton desde widget
            AppIcon(),
            SizedBox(height: 48.0,),
            AppButton(
              color: Colors.lightBlueAccent,
              onPressed: (){Navigator.pushNamed(context,'/login');},
              name: "Log in",
            ),
            AppButton(
              color: Colors.blueAccent,
              onPressed: (){Navigator.pushNamed(context,'/registration');},
              name: "Registrarse",
            )
          
          ],
        )
      ),
    );
  }
}