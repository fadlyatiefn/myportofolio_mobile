import 'package:flutter/material.dart';
import 'package:material_ui/material_ui.dart' as date_material;
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          secondary: Colors.amber[700],
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: date_material.GlobalMaterialLocalizations.delegates,
      home: MyHomePage(),
    );
  }
}

