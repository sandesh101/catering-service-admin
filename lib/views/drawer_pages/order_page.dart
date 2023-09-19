import 'package:catering_service_adming/constant.dart';
import 'package:catering_service_adming/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    // getOrders();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<OrderProvider>(context, listen: false).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order'),
          centerTitle: true,
        ),
        body: Consumer<OrderProvider>(
          builder: (context, orderProvider, _) => ListView.builder(
              shrinkWrap: true,
              itemCount: orderProvider.orderList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.blackColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.red,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orderProvider.orderList[index]['name']
                                          .toString(),
                                      style: AppTextStyle.normalText(
                                          color: ColorConstant.primaryColor),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Iconsax.calendar_1,
                                            color: ColorConstant.primaryColor),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          orderProvider.orderList[index]
                                              ['date'],
                                          style: AppTextStyle.normalText(
                                              color:
                                                  ColorConstant.primaryColor),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.location,
                                    color: ColorConstant.primaryColor),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  orderProvider.orderList[index]['location']
                                      .toString(),
                                  style: AppTextStyle.normalText(
                                      fontSize: 18,
                                      color: ColorConstant.primaryColor),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Food Items 👇",
                                      style: AppTextStyle.normalText(
                                          fontSize: 18,
                                          color: ColorConstant.primaryColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                            orderProvider.orderList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 40.0),
                                            child: Text(
                                              "- ${orderProvider.orderList[index]['food_items']}",
                                              style: AppTextStyle.normalText(
                                                  color: ColorConstant
                                                      .primaryColor),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Positioned(
                        top: 100,
                        left: 200,
                        child: Image(
                          height: 100,
                          image: AssetImage('assets/images/jeri.png'),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
