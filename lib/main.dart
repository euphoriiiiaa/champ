import 'package:champ/api/supabase.dart';
import 'package:champ/presentation/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late final ValueNotifier<int> notifier;

void main() async {
  SupabaseInit().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Чемпионат',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
