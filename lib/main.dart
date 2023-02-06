import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:coinstat/home_page.dart';
import 'package:coinstat/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'models/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPService(); //the order is of optimum importance
  // GetIt.instance.get<HTTPService>().get('/coins/bitcoin');
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String _configContent =
      await rootBundle.loadString("assets/config/main.json");
  Map _configData = jsonDecode(_configContent);
  GetIt.instance.registerSingleton<AppConfig>(
      AppConfig(COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"]));
}

void registerHTTPService() {
  GetIt.instance.registerSingleton<HTTPService>(HTTPService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'benson akaiso\'s coinstat',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(88, 60, 197, 1.0),
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
