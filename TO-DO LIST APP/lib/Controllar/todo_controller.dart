import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/todo_modals.dart';

class Todocontroller {
  List<Todo> todoList = [];
  List<Todo>? searchedTodolist;
  String message = "";

  void addtodo(
      String title, String description, DateTime date, BuildContext context,
      {File? image}) {
    Todo _todo = Todo(
        title: title, description: description, todoDay: date, image: image);
    todoList.add(_todo);

    Navigator.pop(context);
    setData();
  }

  List<String> ConvertTodolistintoStringList() {
    List<Map<String, dynamic>> todoInMap =
        todoList.map((e) => e.toJson()).toList();
    List<String> todoInString = todoInMap.map((e) => jsonEncode(e)).toList();

    return todoInString;
  }

  void ConvertStringlistintoTodoList(List<String> todoInString) {
    List todoInMap = todoInString.map((e) => jsonDecode(e)).toList();
    List<Todo> todoInClass = todoInMap.map((e) => Todo.fromJson(e)).toList();

    todoList = todoInClass;
  }

  Future<void> setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('todo_list', ConvertTodolistintoStringList());
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? todoInString = prefs.getStringList('todo_list');
    ConvertStringlistintoTodoList(todoInString ?? []);
  }

  void searchTodo(String searchKey) {
    if (searchKey.isEmpty) {
      searchedTodolist = null;
    } else {
      List<Todo> results = todoList
          .where((element) => element.title.contains(searchKey))
          .toList();

      searchedTodolist = results;
    }
  }
}
