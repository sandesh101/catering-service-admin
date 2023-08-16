import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<dynamic> _orderList = [];

  List<dynamic> get orderList => _orderList;

  setOrderList(List<dynamic> orders) {
    _orderList = orders;
    notifyListeners();
  }

  Future getOrders() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection('orders');
      QuerySnapshot orderSnap = await ref.get();

      final data = orderSnap.docs.map((docs) => docs.data()).toList();
      await setOrderList(data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
