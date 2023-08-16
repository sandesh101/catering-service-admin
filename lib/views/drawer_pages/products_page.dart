import 'dart:io';

import 'package:catering_service_adming/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../widgets/snackbar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  XFile? pickedImage;
  bool isPickedImage = false;
  String imageUniqueName = '';
  bool isUploadSuccess = true;
  Future pickImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          isPickedImage = true;
          imageUniqueName = DateTime.now().millisecondsSinceEpoch.toString() +
              pickedImage!.name;
        });
      }
      // print(imageUniqueName);
    } catch (e) {
      print(e);
    }
  }

//Function to upload images to cloud storage
  uploadProductImages(dynamic image) async {
    Reference ref =
        _firebaseStorage.ref().child('Products').child(imageUniqueName);
    UploadTask uploadTask = ref.putFile(File(image.path).absolute);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Function to upload images to firestore database
  uploadToDatabase(String productName) async {
    try {
      setState(() {
        isUploadSuccess = false;
      });
      if (isPickedImage) {
        String imageUrl = await uploadProductImages(pickedImage);
        await _firebaseFirestore
            .collection('products')
            .doc(imageUniqueName)
            .set({"product_name": productName, "images": imageUrl}).then(
                (value) {
          setState(() {
            isUploadSuccess = true;
          });
          CustomSnackbar.showSuccessSnack(
              context, "Product Uploaded Successfully");
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

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
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: isPickedImage
                    ? Image(
                        fit: BoxFit.contain,
                        image: XFileImage(pickedImage!),
                      )
                    : Image.asset('assets/images/default_placeholder.png')
                // child: ,
                ),
            const SizedBox(
              height: 20,
            ),
            //Button to pick image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage();
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
                isPickedImage
                    ? GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            uploadToDatabase(_productController.text);
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
                            child: isUploadSuccess
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
              ],
            ),
            //Button to pick image
          ],
        ),
      ),
    );
  }
}
