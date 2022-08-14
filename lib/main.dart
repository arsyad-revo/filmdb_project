import 'package:filmdb_project/providers/movies_provider.dart';
import 'package:filmdb_project/screens/home_screen.dart';
import 'package:filmdb_project/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
      ChangeNotifierProvider<MoviesNotifier>(
          create: (context) => MoviesNotifier())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, value, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: value.getTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
