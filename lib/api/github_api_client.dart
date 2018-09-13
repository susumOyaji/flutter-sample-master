import 'dart:async';
import 'dart:convert';// show json, LineSplitter, utf8;
import 'dart:io';
import 'package:http/http.dart' as http;
//import 'dart:convert';

import 'package:flutter_app/model/github_repo.dart';


class GithubClient {

  Future<List<GithubRepo>> get(String query) async {
    //var url = 'https://api.github.com/search/repositories?sort=stars&q=';
    //var httpClient = new HttpClient();

    try {
      var /*final*/ response = await http.get('https://api.github.com/search/repositories?sort=stars&q=Flutter');
      //var request = await httpClient.getUrl(Uri.parse(url + query));
      //response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        return null;
      }

      //var json = await response.transform(utf8.decoder).join();
      return GithubRepo.fromJson(json.decode(response.body));

    } catch (exception) {
      return null;
    }
  }
}
