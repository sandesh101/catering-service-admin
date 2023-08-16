import 'dart:io';

import 'package:catering_service_adming/constant.dart';
import 'package:catering_service_adming/views/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file_image/cross_file_image.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  //creating instance of firebase storage
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
      debugPrint(e.toString());
    }
  }

//Function to upload images to cloud storage
  uploadSliderImages(dynamic image) async {
    Reference ref =
        _firebaseStorage.ref().child('Sliders').child(imageUniqueName);
    UploadTask uploadTask = ref.putFile(File(image.path).absolute);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//Function to upload images to firestore database
  uploadToDatabase() async {
    try {
      setState(() {
        isUploadSuccess = false;
      });
      if (isPickedImage) {
        String imageUrl = await uploadSliderImages(pickedImage);
        await _firebaseFirestore
            .collection('sliders')
            .doc(imageUniqueName)
            .set({"images": imageUrl}).then((value) {
          setState(() {
            isUploadSuccess = true;
          });
          CustomSnackbar.showSuccessSnack(
              context, "Image Uploaded Successfully");
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Slider Images'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Picked Image
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
                          uploadToDatabase();
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
                                    "Save Image",
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

            const SizedBox(
              height: 20,
            ),
            Divider(
              color: ColorConstant.blackColor,
              thickness: 2,
              indent: MediaQuery.of(context).size.width * 0.04,
              endIndent: MediaQuery.of(context).size.width * 0.04,
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.04,
                  MediaQuery.of(context).size.height * 0.01,
                  0.0,
                  MediaQuery.of(context).size.height * 0.01,
                ),
                child: Text(
                  'Current Slider Images',
                  style: AppTextStyle.normalText(fontSize: 20),
                ),
              ),
            ),
            Divider(
              color: ColorConstant.blackColor,
              thickness: 2,
              indent: MediaQuery.of(context).size.width * 0.04,
              endIndent: MediaQuery.of(context).size.width * 0.04,
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('sliders').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        // Access the document data
                        var imageUrl = snapshot.data!.docs[index]['images'];

                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
