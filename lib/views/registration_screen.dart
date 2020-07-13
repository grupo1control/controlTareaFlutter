import 'package:control_tareas_app/widgets/app_button.dart';
import 'package:control_tareas_app/widgets/app_icon.dart';
import 'package:control_tareas_app/widgets/app_textfield.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget{
  
  static const String routeName ="/registration";
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>{

  //tomar email y correo de funcionario
  //String _email;
  //String _contrasenia;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppIcon(),
            SizedBox(height: 48.0),
            AppTextField(inputText: "Ingresar nombre"),
            SizedBox(height: 8.0),
            AppTextField(inputText: "Ingresar rut"),
            SizedBox(height: 8.0),
            AppTextField(inputText: "Ingresar correo"),
            SizedBox(height: 8.0),
            AppTextField(inputText: "Ingresar contraseña"),
            SizedBox(height: 24.0),
            AppButton(
              color: Colors.blueAccent,
              onPressed: (){},
              name: "Registrarse",
            )
          ],
        ),
      ),
    );
  }
}