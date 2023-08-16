import 'package:catering_service_adming/constant.dart';
import 'package:catering_service_adming/provider/order_provider.dart';
import 'package:catering_service_adming/provider/product_provider.dart';
import 'package:catering_service_adming/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HotCase',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorConstant.secondaryColor,
            centerTitle: true,
            titleTextStyle: AppTextStyle.normalText(fontSize: 20),
          ),
        ),
        initialRoute: "/",
        routes: appRoutes,
      ),
    );
  }
}
