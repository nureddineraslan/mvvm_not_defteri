import 'package:flutter/material.dart';
import 'package:mvvm_with_bloc/views/NoteListView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home:NoteListView(),
    );
  }
}
