import 'package:control_tareas_app/src/screens/home_page.dart';
import 'package:control_tareas_app/src/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:control_tareas_app/src/screens/login_screen.dart';
import 'package:control_tareas_app/src/screens/welcome_screen.dart';
import 'package:control_tareas_app/src/screens/home_page.dart';

void main() {

  runApp(
    MaterialApp(
      home: WelcomeScreen(),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black45)
        ),
      ),
      //navegación pantallas
      initialRoute: WelcomeScreen.routeName,
      routes: <String, WidgetBuilder>{
        LoginScreen.routeName: (BuildContext context) => LoginScreen(),
        WelcomeScreen.routeName: (BuildContext context) => WelcomeScreen(),
        RegistrationScreen.routeName: (BuildContext context) => RegistrationScreen(),
        HomePage.routeName: (BuildContext context) => HomePage()
      },
    )
  );
}
