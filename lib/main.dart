import 'package:flutter/material.dart';

import 'logic/document_controller.dart';
import 'ui/screens/document_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final documentController = DocumentController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản lý Tài liệu Cashew',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: DocumentListScreen(controller: documentController),
    );
  }
}
