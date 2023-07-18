import 'package:catering_service_adming/constant.dart';
import 'package:catering_service_adming/provider/order_provider.dart';
import 'package:catering_service_adming/views/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<OrderProvider>(context, listen: false).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.secondaryColor,
          title:
              Text("Dashboard", style: AppTextStyle.normalText(fontSize: 20)),
          centerTitle: true,
        ),
        drawer: const AppDrawer(),
        body: Consumer<OrderProvider>(builder: (context, orderProvider, _) {
          print(orderProvider.orderList);
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          orderProvider.orderList.length.toString(),
                          style: AppTextStyle.boldText(
                            color: ColorConstant.primaryColor,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "Orders",
                          style: AppTextStyle.normalText(
                              color: ColorConstant.primaryColor, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "3",
                              style: AppTextStyle.boldText(
                                color: ColorConstant.primaryColor,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              "Orders",
                              style: AppTextStyle.normalText(
                                  color: ColorConstant.primaryColor,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        }));
  }
}
