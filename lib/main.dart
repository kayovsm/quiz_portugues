import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'app/routes/routes_mobile.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // CARREGA AS VARIÁVEIS DE AMBIENTE
  print('LOG * Carregando variáveis de ambiente 1');
  try {
    await dotenv.load(fileName: ".env");
    print('LOG * Carregando variáveis de ambiente 2');
  } catch (e) {
    print('LOG * Erro ao carregar variáveis de ambiente 3: $e');
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesMobile.loginPage,
      getPages: RoutesMobile.pages,
    );
  }
}
