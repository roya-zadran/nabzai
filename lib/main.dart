import 'package:flutter/material.dart';
import 'package:nabzai/pages/splashPage.dart';
import 'package:nabzai/utilitise/constants.dart';

void main() {
  runApp(const NabzAiApp());
}



class NabzAiApp extends StatelessWidget {
  const NabzAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NABZ AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: deepTeal),
        scaffoldBackgroundColor: darkTeal,
      ),
      // Dari and Persian are written from right to left.
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child ?? const SizedBox.shrink(),
      ),
      home: const SplashScreen(),
    );
  }
}

