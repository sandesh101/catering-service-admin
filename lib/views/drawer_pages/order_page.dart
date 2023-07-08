import 'package:catering_service_adming/constant.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<String> foodItems = [
    "Momo",
    "Pizza",
    "Burger",
    "French Fries",
    "Chicken Chilli"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        centerTitle: true,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.red,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sandesh Rimal",
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
                                      "2080-09-09",
                                      style: AppTextStyle.normalText(
                                          color: ColorConstant.primaryColor),
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
                            Text(
                              "Jarankhu, Kathmandu",
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
                                    itemCount: foodItems.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: Text(
                                          "- ${foodItems[index]}",
                                          style: AppTextStyle.normalText(
                                              color:
                                                  ColorConstant.primaryColor),
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
    );
  }
}
