import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future fetchPost(String code) async {
  //inal response = await http.get('https://jsonplaceholder.typicode.com/posts/21');
  //final response = await http.get('https://www.yahho.co.jp');
   final response= await http.get('https://info.finance.yahoo.co.jp/search/?query='+code);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return  response.body;//Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}



void main() => runApp(MyAppjson());

class MyAppjson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: FutureBuilder(
              future: fetchPost("6976"),
              builder: (context, returndata) {
                if (returndata.hasError) print(returndata.error);

                return returndata.hasData ? Center(child: Text(returndata.requireData )): Center(child: CircularProgressIndicator());
              },
          ),
        
      ),
    );
  }
}