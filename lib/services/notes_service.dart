import 'dart:convert';

import 'package:control_tareas_app/models/api_response.dart';
import 'package:control_tareas_app/models/note.dart';
import 'package:control_tareas_app/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:control_tareas_app/models/note_insert.dart';

class NotesService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apiKey': '86b9e651-b2ed-4ddc-9994-7b387444cbdd',
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'Ha ocurrido un error'));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<Note>(error: true, errorMessage: 'Ha ocurrido un error'));
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(API + '/notes', headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error'));
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(API + '/notes/' + noteID, headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error'));
  }

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error'));
  }
}
