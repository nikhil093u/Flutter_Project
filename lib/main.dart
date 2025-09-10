import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/authprovider.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:flutter_application/features/orders/orderprovider.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.root,
    );
  }
}
