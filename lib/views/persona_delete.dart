import 'package:flutter/material.dart';

class PersonaDelete extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Precaución'),
      content: Text('Estás seguro que deseas eliminar esta persona?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Sí'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}