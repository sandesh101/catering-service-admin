import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  XFile? _pickedImage;
  bool _isPickedImage = false;
  String _imageUniqueName = '';
  bool _isUploadSuccess = true;
  List<dynamic> _productList = [];

  XFile? get pickedImage => _pickedImage;
  bool get isPickedImage => _isPickedImage;
  String get imageUniqueName => _imageUniqueName;
  bool get isUploadSuccess => _isUploadSuccess;
  List<dynamic> get productList => _productList;

  setIsPickedImage(bool value) {
    _isPickedImage = value;
    notifyListeners();
  }

  setIsUploadSuccess(bool value) {
    _isUploadSuccess = value;
    notifyListeners();
  }

  setImageName() {
    setIsPickedImage(true);
    _imageUniqueName =
        DateTime.now().millisecondsSinceEpoch.toString() + pickedImage!.name;
  }

  setPickedImage(XFile? image) {
    _pickedImage = image;
    notifyListeners();
  }

  setProductList(List<dynamic> product) {
    _productList = product;
    notifyListeners();
  }

  Future pickImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setPickedImage(_pickedImage);
        setImageName();
      }
      // print(imageUniqueName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Function to upload images to cloud storage
  uploadProductImages(dynamic image) async {
    Reference ref =
        _firebaseStorage.ref().child('Products').child(_imageUniqueName);
    UploadTask uploadTask = ref.putFile(File(image.path).absolute);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Function to upload images to firestore database
  uploadToDatabase(String productName) async {
    try {
      setIsUploadSuccess(false);
      if (isPickedImage) {
        String imageUrl = await uploadProductImages(pickedImage);
        await _firebaseFirestore
            .collection('products')
            .doc(imageUniqueName)
            .set({"product_name": productName, "images": imageUrl}).then(
                (value) {
          setIsUploadSuccess(true);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getProducts() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('products');
      QuerySnapshot orderSnap = await ref.get();

      final data = orderSnap.docs.map((docs) => docs.data()).toList();
      await setProductList(data);

      // print("DATA: $data");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
