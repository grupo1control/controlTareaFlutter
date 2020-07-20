import 'package:control_tareas_app/models/asignacion_for_listing.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:control_tareas_app/models/api_response.dart';
import 'package:control_tareas_app/services/asignaciones_service.dart';
import 'package:control_tareas_app/views/persona_delete.dart';
import 'persona_modify.dart';

class AsignacionList extends StatefulWidget {
  @override
  _AsignacionListState createState() => _AsignacionListState();
}

class _AsignacionListState extends State<AsignacionList> {
  AsignacionesService get service => GetIt.I<AsignacionesService>();

  APIResponse _apiResponse;
  bool _isLoading = false;
  List<AsignacionForListing> _asignacionesPorUsuario = []; // Lista Filtrada
  int _codigoUsuario = 13;                                 // Código Usuario Logueado

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchAsignaciones();
    super.initState();
  }

  _fetchAsignaciones() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getAsignacionesList();
    filtrarAsignaciones();


    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //filtrarAsignaciones();
    return Scaffold(
        appBar: AppBar(title: Text('Lista de asignaciones')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PersonaModify()))
                .then((_) {
                  _fetchAsignaciones();
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
                  key: ValueKey(_asignacionesPorUsuario[index].pkAsignacion.fkTarea.codigo),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => PersonaDelete());
                        
                    // if (result) {
                    //   final deleteResult = await service.deletePersona(_apiResponse.data[index].rut);

                    //   var message;
                    //   if (deleteResult != null && deleteResult.data == true) {
                    //     message = 'La persona fué eliminada exitosamente';
                    //   } else {
                    //     message = deleteResult?.errorMessage ?? 'Ha ocurrido un error';
                    //   }

                    // showDialog(
                    //   context: context, builder: (_) => AlertDialog(
                    //     title: Text('Listo'),
                    //     content: Text(message),
                    //     actions: <Widget>[
                    //       FlatButton(child: Text('Ok'), onPressed: () {
                    //         Navigator.of(context).pop();
                    //       })
                    //     ],
                    //   ));

                    //   return deleteResult?.data ?? false;
                    // }

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
                      _asignacionesPorUsuario[index].pkAsignacion.fkTarea.nombre,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        _asignacionesPorUsuario[index].pkAsignacion.fkTarea.descripcion),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (_) => PersonaModify(
                    //           rut: _apiResponse.data[index].rut))).then((data) {
                    //             _fetchAsignaciones();
                    //           });
  
                    // },
                  ),
                );
              },
              itemCount: _asignacionesPorUsuario.length,
            );
          },
        ));
  }
          //Filtrar Asignaciones por Usuario
            filtrarAsignaciones(){
              List<AsignacionForListing> tmp = [];
              _asignacionesPorUsuario.clear();
              tmp = [];
              for (AsignacionForListing asig in _apiResponse.data){
                if (asig.pkAsignacion.fkIntegrante.pkIntegrante.fkUsuario.id == _codigoUsuario){
                  tmp.add(asig);
                }
              _asignacionesPorUsuario = tmp;

              }
                  debugPrint(_asignacionesPorUsuario.toString());
            }
}