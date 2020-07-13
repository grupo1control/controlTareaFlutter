import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:control_tareas_app/models/api_response.dart';
import 'package:control_tareas_app/services/personas_service.dart';
import 'package:control_tareas_app/views/persona_delete.dart';
import 'persona_modify.dart';

class PersonaList extends StatefulWidget {
  @override
  _PersonaListState createState() => _PersonaListState();
}

class _PersonaListState extends State<PersonaList> {
  PersonasService get service => GetIt.I<PersonasService>();

  APIResponse _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchPersonas();
    super.initState();
  }

  _fetchPersonas() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getPersonasList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Lista de personas')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PersonaModify()))
                .then((_) {
                  _fetchPersonas();
                });
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_apiResponse.error) {
              return Center(child: Text(_apiResponse.errorMessage));
            }

            return ListView.separated(
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.green),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data[index].rut),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => PersonaDelete());
                        
                    if (result) {
                      final deleteResult = await service.deletePersona(_apiResponse.data[index].rut);

                      var message;
                      if (deleteResult != null && deleteResult.data == true) {
                        message = 'La persona fué eliminada exitosamente';
                      } else {
                        message = deleteResult?.errorMessage ?? 'Ha ocurrido un error';
                      }

                    showDialog(
                      context: context, builder: (_) => AlertDialog(
                        title: Text('Done'),
                        content: Text(message),
                        actions: <Widget>[
                          FlatButton(child: Text('Ok'), onPressed: () {
                            Navigator.of(context).pop();
                          })
                        ],
                      ));

                      return deleteResult?.data ?? false;
                    }

                    print(result);
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      _apiResponse.data[index].nombre,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        'Last edited on ${formatDateTime(_apiResponse.data[index].modificada ?? _apiResponse.data[index].creada)}'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PersonaModify(
                              rut: _apiResponse.data[index].rut))).then((data) {
                                _fetchPersonas();
                              });
  

                    },
                  ),
                );
              },
              itemCount: _apiResponse.data.length,
            );
          },
        ));
  }
}