import 'package:flutter/material.dart';
import 'package:labsec_app/providers/devices_provider.dart';
import 'package:labsec_app/providers/generate_key_provider.dart';
import 'package:labsec_app/providers/signature_provider.dart';
import 'package:labsec_app/screens/home_screen.dart';
import 'package:labsec_app/styles/custom_colors.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DevicesProvider()),
          ChangeNotifierProvider(create: (context) => GenerateKeyProvider()),
          ChangeNotifierProvider(create: (context) => SignatureProvider()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: myColors.primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: myColors.primary,
            side: BorderSide(color: myColors.primary, width: 1.5),
            padding: EdgeInsets.all(15),
            minimumSize: Size(200.0, 50.0),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        appBarTheme:
            AppBarTheme(centerTitle: true, titleTextStyle: TextStyle()),
      ),
    );
  }
}
