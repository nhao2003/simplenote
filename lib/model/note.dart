import 'package:flutter/material.dart';

class Note {
  final String id;
  DateTime date;
  String title;
  String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });
}
