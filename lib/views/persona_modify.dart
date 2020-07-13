import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:control_tareas_app/models/persona.dart';
import 'package:control_tareas_app/services/personas_service.dart';
import 'package:control_tareas_app/models/persona_insert.dart';

class PersonaModify extends StatefulWidget {
 
  final String rut;
  PersonaModify({this.rut});

  @override
  _PersonaModifyState createState() => _PersonaModifyState();
}

class _PersonaModifyState extends State<PersonaModify> {
  bool get isEditing => widget.rut != null;

  PersonasService get personasService => GetIt.I<PersonasService>();

  String errorMessage;
  Persona persona;

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _rutController = TextEditingController();
  DateTime _natalicio;


  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

  if (isEditing) {  
    setState(() {
      _isLoading = true;
    });
    personasService.getPersona(widget.rut)
      .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        persona = response.data;
        _nombreController.text = persona.nombre;
        _apellidoController.text = persona.apellido;
        _rutController.text = persona.rut;
        _natalicio = persona.natalicio;
      });
    }  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Persona' : 'Create Persona')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                hintText: 'Persona nombre'
              ),
            ),

            Container(height: 8),

            TextField(
              controller: _apellidoController,
              decoration: InputDecoration(
                hintText: 'Persona apellido'
              ),
            ),

            Container(height: 8),
          
            TextField(
              controller: _rutController,
              decoration: InputDecoration(
                hintText: 'Persona rut'
              ),
            ),

            Container(height: 8),

            Text(_natalicio == null ? 'Nothing has been picked yet' : _natalicio.toString().substring(0,10)),
            RaisedButton(
              child: Text('Pick a date'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _natalicio == null ? DateTime.now() : _natalicio,
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2021)
                ).then((date) {
                  setState(() {
                    _natalicio = date;
                  });
                });
              },
            ),

            Container(height: 16),

            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (isEditing) {
                    setState(() {
                      _isLoading = true;
                    });
                    final persona = PersonaInsert(
                      nombre: _nombreController.text,
                      apellido: _apellidoController.text,
                      rut:  _rutController.text,
                      natalicio: _natalicio 
                    );
                    final result = await personasService.updatePersona(widget.rut, persona);
                    
                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your Persona was updated';

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(title),
                        content: Text(text),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      )
                    )
                    .then((data) {
                      if (result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  } else {
                    
                    setState(() {
                      _isLoading = true;
                    });
                    final persona = PersonaInsert(
                      nombre: _nombreController.text,
                      apellido: _apellidoController.text,
                      rut:  _rutController.text,
                      natalicio: _natalicio                       
                    );
                    final result = await personasService.createPersona(persona);
                    
                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your Persona was created';

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(title),
                        content: Text(text),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      )
                    )
                    .then((data) {
                      if (result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}