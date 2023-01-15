import 'package:flutter/material.dart';
import './services/post_provider.dart';
import 'package:provider/provider.dart';

import './widgets/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PostProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Sanal Post',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.black,
              buttonTheme: ButtonThemeData(buttonColor: Colors.black),
              iconTheme: IconThemeData(color: Colors.orange[700]),
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black)),
          home: HomeScreen()),
    );
  }
}
