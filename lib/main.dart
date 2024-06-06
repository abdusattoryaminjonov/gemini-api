import 'package:flutter/material.dart';
import 'package:gemini_https/core/config/root_binding.dart';
import 'package:gemini_https/presentation/pages/home_page.dart';
import 'package:gemini_https/presentation/pages/starter_page.dart';
import 'package:get/get.dart';

import 'core/services/root_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await RootService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StarterPage(),
      initialBinding: RootBinding(),
      routes: {
        HomePage.id :(context) => HomePage()
      },
    );
  }
}