import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();
  //print(_data);
  String _title = _data[0]['title'];
  String _body = _data[0]['body'];

  runApp(new MaterialApp(
    title: "Parsing JSON",
    home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Parsing JSON"),
        ),
        body: new ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(10.0),
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) {
                return new Divider();
              }

              final index = position ~/ 2;


              return new ListTile(
                title: new Text(
                  "${_data[index]['title']}",
                  style: new TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold),
                ),
                subtitle: new Text("${_data[index]['body']}",
                style: new TextStyle(
                  fontSize: 16
                ),),

                leading: new CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: new Text(
                    "${_data[index]['title'][0].toString().toUpperCase()}",
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                onTap: () => _showOnTapMessage(context, "${_data[index]['title']}"),
              );
            })),
  ));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text("Alert!"),
    content: new Text(message),
    actions: <Widget>[
      new RaisedButton(onPressed: (){Navigator.pop(context);},
          child: new Text("close"),
          color: Colors.red,
      )
    ],
  );
  showDialog(context: context, child: alert);
}

Future<List> getJson() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}


