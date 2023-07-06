import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomSnackbar {
  static void showErrorSnack(BuildContext context, String message) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 2),
      elevation: 3.0,
      // width: MediaQuery.of(context).size.width * 0.2,
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: AppTextStyle.normalText(color: ColorConstant.primaryColor),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showSuccessSnack(BuildContext context, String message) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 2),
      elevation: 3.0,
      // width: MediaQuery.of(context).size.width * 0.2,
      backgroundColor: Color.fromARGB(255, 56, 202, 27),
      content: Text(
        message,
        style: AppTextStyle.normalText(color: ColorConstant.primaryColor),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
