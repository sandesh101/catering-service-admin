import 'package:catering_service_adming/constant.dart';
import 'package:catering_service_adming/provider/product_provider.dart';
import 'package:catering_service_adming/views/widgets/snackbar.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _productController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _productController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Must Have Product Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text(
                      "Add Product",
                      style: AppTextStyle.normalText(),
                    ),
                  ),
                ),
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, product, _) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: product.isPickedImage
                      ? Image(
                          fit: BoxFit.contain,
                          image: XFileImage(product.pickedImage!),
                        )
                      : Image.asset('assets/images/default_placeholder.png')
                  // child: ,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            //Button to pick image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<ProductProvider>(
                  builder: (context, provider, _) => GestureDetector(
                    onTap: () {
                      provider.pickImage();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: ColorConstant.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Pick Image",
                          style: AppTextStyle.normalText(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<ProductProvider>(
                  builder: (context, provider, _) => provider.isPickedImage
                      ? GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await provider
                                  .uploadToDatabase(_productController.text)
                                  .then(
                                    (value) => CustomSnackbar.showSuccessSnack(
                                        context, "Product Added!!"),
                                  );
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              color: ColorConstant.secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: provider.isUploadSuccess
                                  ? Text(
                                      "Save Product",
                                      style: AppTextStyle.normalText(
                                        fontSize: 20,
                                      ),
                                    )
                                  : Lottie.asset(
                                      'assets/animations/loading.json',
                                      height: 120,
                                    ),
                            ),
                          ),
                        )
                      : Container(),
                )
              ],
            ),
            //Button to pick image
          ],
        ),
      ),
    );
  }
}
