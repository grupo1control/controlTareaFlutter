import 'package:control_tareas_app/services/personas_service.dart';
import 'package:control_tareas_app/views/home_page.dart';
import 'package:control_tareas_app/views/persona_list.dart';
import 'package:control_tareas_app/views/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:control_tareas_app/views/login_screen.dart';
import 'package:control_tareas_app/views/welcome_screen.dart';
import 'package:control_tareas_app/views/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:control_tareas_app/services/notes_service.dart';
import 'package:control_tareas_app/views/note_list.dart';
import 'package:control_tareas_app/views/login.dart';

void setupLocator() {
 // GetIt.I.registerLazySingleton(() => NotesService());
       GetIt.I.registerLazySingleton(() => PersonasService());

}

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Tareas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//    home: NoteList(),  // Original example
//    home: PersonaList(), // Persona CRUD
      home: MyApp(),

    );
  }
}
//void main() {
//  setupLocator();
//  runApp(
//    MaterialApp(
//      home: NoteList(),
//      theme: ThemeData(
//        textTheme: TextTheme(
//          bodyText2: TextStyle(color: Colors.black45)
//        ),
//      ),
//      //navegación pantallas
//      initialRoute: WelcomeScreen.routeName,
//      routes: <String, WidgetBuilder>{
//        LoginScreen.routeName: (BuildContext context) => LoginScreen(),
//        WelcomeScreen.routeName: (BuildContext context) => WelcomeScreen(),
//        RegistrationScreen.routeName: (BuildContext context) => RegistrationScreen(),
//        HomePage.routeName: (BuildContext context) => HomePage(),
//
//      },
//    )
//  );
//}
