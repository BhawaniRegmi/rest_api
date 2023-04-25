import 'package:flutter/material.dart';
import 'package:rest_api/jasonModel.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Welcome> lista = [];
  Future<List<Welcome>> geto() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var jsonResponse = convert.jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in jsonResponse) {
        lista.add(Welcome.fromJson(index));
      }
      return lista;
    } else {
      return lista;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api"),
      ),
      body: Container(
        child: FutureBuilder(
            future: geto(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 290,
                        color: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Body:${lista[index].body}"),
                              Text("Id:${lista[index].id}"),
                              Text("Title:${lista[index].title}"),
                              Text("userId:${lista[index].userId}"),
                            ]),
                      );
                    });
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
