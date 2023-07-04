import 'package:catering_service_adming/constant.dart';
import 'package:catering_service_adming/views/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.secondaryColor,
        title: Text("Dashboard", style: AppTextStyle.normalText(fontSize: 20)),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
    );
  }
}
