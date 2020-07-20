
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';
import 'package:control_tareas_app/services/usuarios_service.dart';
import 'package:get_it/get_it.dart';
import 'package:control_tareas_app/models/api_response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:control_tareas_app/models/usuario_for_listing.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  UsuarioService get service => GetIt.I<UsuarioService>();
  APIResponse _apiResponse;
  bool _isLoading = false;
  FlutterToast flutterToast;
List<UsuarioForListing> _matchUsuario = [];  
    @override
  void initState() {  
    _fetchUsuarios();
    super.initState();
    checkIfAlreadyLogin();

  }
    _fetchUsuarios() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getUsuariosList();

    // setState(() {
    //   _isLoading = false;
    // });
  }
    
    //flutterToast = FlutterToast(context);
    
  
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final username_controller = TextEditingController();
  final correo_controller = TextEditingController();

  SharedPreferences logindata;
  bool newuser;

  void checkIfAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => AsignacionList()));
    }
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
                controller: correo_controller,
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
                String correo = correo_controller.text;
                MatchUser();
                int index = 0; 
                if (username == _matchUsuario[index].nombre  && correo == _matchUsuario[index].correo) {
                  print('Successfull');
                  logindata.setBool('login', false); //Guarda los datos de Usuario en Memoria
                  logindata.setString('usuario', username);
                  logindata.setString('idUsuario', _matchUsuario[index].id.toString());


                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AsignacionList()));
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

         //Hace el Match del Usuario ingresado con el Usuario en la BD
            MatchUser(){
              List<UsuarioForListing> tmp = [];
              _matchUsuario.clear();
              tmp = [];
              for (UsuarioForListing userMatch in _apiResponse.data){
                if (userMatch.nombre == username_controller.text && userMatch.correo == correo_controller.text) {
                  tmp.add(userMatch);
                }
              _matchUsuario = tmp;

              }
                  debugPrint(_matchUsuario.toString());
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
