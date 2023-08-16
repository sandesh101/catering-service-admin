import 'package:catering_service_adming/provider/order_provider.dart';
import 'package:catering_service_adming/provider/product_provider.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  late OrderProvider orderProvider;
  late ProductProvider productProvider;
  List<Map<String, dynamic>> _orderList = [];
  List<Map<String, dynamic>> _productList = [];

  List<Map<String, dynamic>> get orderList => _orderList;
  List<Map<String, dynamic>> get productList => _productList;

  setOrder(List<Map<String, dynamic>> order) {
    _orderList = order;
    notifyListeners();
  }

  setProduct(List<Map<String, dynamic>> product) {
    _orderList = product;
    notifyListeners();
  }

  getOrder() async {
    _orderList = await orderProvider.getOrders();
    setOrder(_orderList);
  }

  getProduct() async {
    _productList = await productProvider.getProducts();
  }
}
