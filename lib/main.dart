import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gemini_https/core/config/root_binding.dart';
import 'package:gemini_https/presentation/pages/home_page.dart';
import 'package:gemini_https/presentation/pages/starter_page.dart';
import 'package:get/get.dart';

import 'core/services/root_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await RootService.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyA-Xjc7gbOUTVKf5gmbqvmOUy34wMYbn6A',
        appId: '1:678415810955:android:1007369062ce7d1d266f8e',
        messagingSenderId: '678415810955',
        projectId: 'gemini-getx',
      )
  );

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
      home: const StarterPage(),
      initialBinding: RootBinding(),
      routes: {
        HomePage.id :(context) => const HomePage(),
        StarterPage.id :(context) => const StarterPage(),
      },
    );
  }
}