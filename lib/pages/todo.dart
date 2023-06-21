import 'package:flutter/material.dart';
import 'package:trabalho_final_pdm/widgets/check_item.dart';

class ToDo extends StatefulWidget {
  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text('Realize'),
      ),
    ));
  }
}
