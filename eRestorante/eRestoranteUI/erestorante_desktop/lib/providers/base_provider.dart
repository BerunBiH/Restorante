import 'dart:convert';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

abstract class BaseProvider<T> with ChangeNotifier{
  static String? _baseUrl;
  String _endpoint="";
  
  BaseProvider(String endpoint){
    _endpoint = endpoint;
    _baseUrl=const String.fromEnvironment("baseUrl", defaultValue: "http://localhost:5266/");
  }

  Future<SearchResult<T>> get({dynamic filter}) async{
    var url = "$_baseUrl$_endpoint";

    if(filter != null)
    {
      var querryString = getQueryString(filter);
      url = "$url?$querryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if(isValidResponse(response))
    {
      var data = jsonDecode(response.body);

      var result = SearchResult<T>();

      result.count = data['count'];

      for (var item in data['result']){
        result.result.add(fromJson(item));
      }

      return result;
    }
    else{
      throw new Exception("Upps, something went wrong");
    }
  }

  T fromJson(data){
    throw Exception("Method not implemented");
  }

  bool isValidResponse(Response response){
    if (response.statusCode < 299)
    {
      return true;
    }
    else if (response.statusCode == 401){
      throw new Exception("Unauthorised");
    }
    else{
      throw new Exception("Upps, something went wrong");
    }
  }

  Map<String, String> createHeaders(){
    String username = Authorization.email ?? "";
    String password = Authorization.password ?? "";

    String basicAuth = "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }

 String getQueryString(Map params,
      {String prefix= '&', bool inRecursion= false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

}