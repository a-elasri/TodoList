import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/task_model.dart';

class TodoProvider{

  Map<String, String> customeHearders={
    "Accept": 'application/json',
    "Content-type": "application/json; charset=UTF-8"
  };

  //Get request
  Future<List<TaskModel>> fetchData() async{
   try{
     //change the localhost to yours
     final Uri restAPIURL= Uri.parse("http://192.168.11.114:3000/api/v1/tasks");
     http.Response response= await http.get(restAPIURL);
     final parsedData= await json.decode(response.body);
     List todoData= List.from(parsedData['data']['tasks']);
     return await todoData.map((e) => TaskModel.fromMap(e)).toList();
   }catch(e){
     rethrow;
   }
  }
  //Post Request
  Future addData(Map<String, dynamic> body)async{
    try{
      //change the localhost to yours
      final Uri restAPIURL= Uri.parse('http://192.168.11.114:3000/api/v1/tasks');
      http.Response response= await http.post(restAPIURL, headers: customeHearders,body: jsonEncode(body));
      return response.body;
    }catch(e){
      rethrow;
    }
  }

  //Delete request
  Future deleteData(String id) async{

    try{
      //change the localhost to yours
      final Uri restAPIURL= Uri.parse("http://192.168.11.114:3000/api/v1/tasks/${id}");
      http.Response response= await http.delete(restAPIURL, headers: customeHearders,body: null);

      return response.body;
    }catch(e){
      rethrow;
    }
  }
   Future updateTerminated(String id, Map<String,dynamic> data) async{
    try{
      //change the localhost to yours
      final Uri restAPIURL= Uri.parse("http://192.168.11.114:3000/api/v1/tasks/${id}");
      http.Response response= await http.patch(restAPIURL, headers: customeHearders,body: jsonEncode(data));
      return response.body;
    }catch(e){
      rethrow;
    }
  }

  //Update request
  Future updateData(String id, Map<String,String> data) async{

    try{
      //change the localhost to yours
      final Uri restAPIURL= Uri.parse("http://192.168.11.114:3000/api/v1/tasks/${id}");
      http.Response response= await http.patch(restAPIURL, headers: customeHearders,body: jsonEncode(data));

      return response.body;
    }catch(e){
      rethrow;
    }
  }
}
