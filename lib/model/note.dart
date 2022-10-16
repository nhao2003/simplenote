import 'package:flutter/material.dart';
class Note{
  final String id = DateTime.now().toString();
  DateTime date = DateTime.now();
  late String title;
  late String content;
  Note(this.title, this.content);
}