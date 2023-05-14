import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <Welcome> welcome  = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
              itemCount: welcome.length,
              itemBuilder: (BuildContext context , int index) {
                return Container(
                  margin: const EdgeInsets.all(20.0),
                  height: 230.0,
                  color: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User id: ${welcome[index].userId}',style: TextStyle(fontSize: 18.0),),
                      Text('Id: ${welcome[index].id}',style: TextStyle(fontSize: 18.0),),
                      Text('Title: ${welcome[index].title}',maxLines: 1,style: TextStyle(fontSize: 18.0),),
                      Text('Body: ${welcome[index].body}',maxLines: 1,style: TextStyle(fontSize: 18.0),),
                    ],
                  ),
                );
              }
          );
        }
         else{
           return Center(child: CircularProgressIndicator(),);
        };
      }
    );
  }

  Future<List<Welcome>> getData () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        welcome.add(Welcome.fromJson(index));
      }
      return welcome;
    }else{
      return welcome;
    }
  }

}


