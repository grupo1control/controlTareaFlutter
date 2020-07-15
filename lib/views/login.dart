
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';
import 'package:control_tareas_app/services/usuarios_service.dart';
import 'package:get_it/get_it.dart';
import 'package:control_tareas_app/models/api_response.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  UsuarioService get service => GetIt.I<UsuarioService>();
  APIResponse _apiResponse;
  bool _isLoading = false;
  FlutterToast flutterToast;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  SharedPreferences logindata;
  bool newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfAlreadyLogin();
    _fetchUsuarios();
    flutterToast = FlutterToast(context);
    
  }

  void checkIfAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }
  _fetchUsuarios() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getUsuariosList();

    setState(() {
      _isLoading = false;
    });

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Control tareas"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'usuario',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'correo',
                ),
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                String username = username_controller.text;
                String password = password_controller.text;
                int index = 0; 
                if (username == _apiResponse.data[index].nombre  && password == _apiResponse.data[index].correo) {
                  print('Successfull');
                  logindata.setBool('login', false);

                  logindata.setString('usuario', username);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyDashboard()));
                }else{
                  _showToast();
                }
              },
              child: Text("Log-In"),
            )
          ],
        ),
      ),
    );
  }

  _showToast() {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text("¡Credenciales incorrectas! Intente nuevamente"),
        ],
        ),
    );


    flutterToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
}
}
