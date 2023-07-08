import 'package:catering_service_adming/constant.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Headers
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Column(
                      children: [
                        Text(
                          "SN",
                          style: AppTextStyle.boldText(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Date",
                          style: AppTextStyle.boldText(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Location",
                          style: AppTextStyle.boldText(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "No. of People",
                          style: AppTextStyle.boldText(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //Headers
          //Table body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0),
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${index + 1}",
                                  style: AppTextStyle.normalText(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "2080-01-02",
                                  style: AppTextStyle.normalText(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Jrankhu",
                                  style: AppTextStyle.normalText(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "10",
                                  style: AppTextStyle.normalText(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          ),
          //Table body
        ],
      ),
    );
  }
}
