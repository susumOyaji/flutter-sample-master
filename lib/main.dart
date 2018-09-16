import 'package:flutter/material.dart';
import 'package:flutter_app/api/github_api_client.dart';
import 'package:flutter_app/model/github_repo.dart';
//import 'package:flutter_app/model/jsonsample.dart';
//import 'package:flutter_app/model/photos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';



 




void main() => runApp(new MyApp());//MyApp

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'GitHub Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<GithubRepo> _items;

  var _listViewKey = new Key('ListView');

  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var listView = new ListView(
      key: _listViewKey,
      itemExtent: 50.0,
      children: _createWidgets(_items),
    );
    var container = new Container(
        height: 500.0,
        child: listView
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new TextField(
              decoration: const InputDecoration(
                hintText: 'Flutter',
                labelText: 'Query',
              ),
              maxLines: 1,
              controller: _controller,
            ),
            new Container(
              padding: const EdgeInsets.all(20.0),
              child: new RaisedButton(
                  child: const Text('FlutterSearch'),
                  onPressed:(){
                    FutureBuilder(
                      future: fetchPost("6976"),
                      builder: (context, returndata) {
                        if (returndata.hasError) print(returndata.error);

                        return returndata.hasData ? Center(child: Text(returndata.requireData )): Center(child: CircularProgressIndicator());
                      },
                    );  
                  }
                  
              ),
            ),
            container,
            FutureBuilder(
              future: fetchPost("6976"),
              builder: (context, returndata) {
                if (returndata.hasError) print(returndata.error);

                return returndata.hasData ? Center(child: Text(returndata.requireData )): Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

 
  Future fetchPost(String code) async {
  //inal response = await http.get('https://jsonplaceholder.typicode.com/posts/21');
  //final response = await http.get('https://www.yahho.co.jp');
    final response= await http.get('https://info.finance.yahoo.co.jp/search/?query='+code);
    if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return  response.body;//Post.fromJson(json.decode(response.body));
    } else {
    // If that call was not successful, throw an error.
      throw Exception('Failed to load finance');
    }
  }
 

 

  
  
  
  void _search() {
    var client = new GithubClient();
    client.get(_controller.text).then((result) {
      setState(() {
        _items = result;
      });
    });
  }

  Iterable<Widget> _createWidgets(List<GithubRepo> items) {
    var ret = new List<Widget>();
    if (items == null) {
      return ret;
    }
    items.forEach((item) {
      ret.add(
          new ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage(item.avatarUrl),
            ),
            title: new Text('${item.name} / ⭐ ${item.starCount}'),
          )
      );
    });
    return ret;
  }
}
