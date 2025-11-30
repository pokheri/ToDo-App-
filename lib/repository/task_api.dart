import 'package:flutter/material.dart';
import 'package:todo/services/api_client.dart';

final dio = ApiClient.create();

class TaskApi {
  static const taskBaseUrl = '/store';
  static Future<bool> createnewTask(String title, String description) async {
    // api call to create a new task

    final url = '$taskBaseUrl/create-task/';

    final response = await dio.post(url, data: {"title": title, "description": description});

    if (response.statusCode == 201) {
      return true;
    } else {
      debugPrint("hell");
    }

    return false;
  }

  static Future<bool> updateTask(String title, String description, String id) async {
    // api call to create a new task

    final url = '$taskBaseUrl/update-task/$id/';

    final response = await dio.put(url, data: {"title": title, "description": description});

    if (response.statusCode == 201) {
      return true;
    } else {
      debugPrint("hell");
    }

    return false;
  }

  static Future<bool> deleteTask(String id) async {
    // api call to create a new task

    final url = '$taskBaseUrl/delete-task/$id/';

    final response = await dio.delete(url);

    if (response.statusCode == 204) {
      return true;
    } else {
      debugPrint("hell");
    }

    return false;
  }

  static Future<List<dynamic>> getMyTasks() async {
    final url = '$taskBaseUrl/tasks/';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      print('lets see what typ oe of data we are tying to return ${response.data.runtimeType}');
      print('\n here is the data ${response.data}');
      return response.data;
    }
    return [];
  }
}
