import 'package:flutter/material.dart';
class Note{
  final String id = DateTime.now().toString();
  final DateTime date = DateTime.now();
  late String title;
  late String content;
  Note(this.title, this.content);
}