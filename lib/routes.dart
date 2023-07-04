import 'package:catering_service_adming/views/dashboard/dashboard.dart';
import 'package:catering_service_adming/views/drawer_pages/categories_page.dart';
import 'package:catering_service_adming/views/drawer_pages/order_page.dart';
import 'package:catering_service_adming/views/drawer_pages/products_page.dart';
import 'package:catering_service_adming/views/drawer_pages/slider_upload_page.dart';

final appRoutes = {
  '/': (context) => const Dashboard(),
  'order': (context) => const OrderPage(),
  'categories': (context) => const CategoriesPage(),
  'slider': (context) => const SliderPage(),
  'products': (context) => const ProductPage(),
};
