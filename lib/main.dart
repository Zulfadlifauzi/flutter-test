import 'package:flutter/material.dart';

import 'data/utils/shared_preferences_utils.dart';
import 'src/product_module/presentation/product_index_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesMixin.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          chipTheme: const ChipThemeData(backgroundColor: Colors.white),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          scaffoldBackgroundColor: Colors.white),
      home: const ProductIndexScreen(),
    );
  }
}
