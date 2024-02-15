import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _todos = [];

  Future<List> fetchTodos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    fetchTodos().then((value) {
      setState(() {
        _todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('HTTP Request ',
          style: TextStyle(color: Colors.white),),
      ),

      body: ListView.builder(
        itemCount: _todos.length > 20 ? 20 : _todos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_todos[index]['title']),
            subtitle: Text(_todos[index]['completed'] ? 'Completed' : 'Incomplete'),
            leading: CircleAvatar(
              child: Text(_todos[index]['id'].toString()),
            ),
          );
        },
      ),

    );
  }
}

