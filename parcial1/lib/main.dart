import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parcial1/pages/home_page.dart';
import 'package:parcial1/repositories/product_repository.dart';

void main() {
  final dio = Dio();
  final repository = ProductRepository(dio);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ProductRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Tienda Productos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 161, 135, 207),
        ),
      ),
      home: HomePage(repository: repository),
    );
  }
}
