import 'package:flutter/material.dart';
import 'package:image_editor/providers/app_image_provider.dart';
import 'package:image_editor/screens/filter_screen.dart';
import 'package:image_editor/screens/home_screen.dart';
import 'package:image_editor/screens/start_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AppImageProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artify',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff111111),
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/': (_) => const StartScreen(),
        '/home': (_) => const HomeScreen(),
        '/filter': (_) => const FilterScreen(),
      },
      initialRoute: '/',
    );
  }
}
