import 'package:catering_service_adming/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  Future pickImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      await imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print(e);
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
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              color: Colors.red,
              // child: ,
            ),
            const SizedBox(
              height: 20,
            ),
            //Button to pick image
            GestureDetector(
              onTap: () {
                print('TAPPED');
                pickImage();
              },
              child: Container(
                height: 60,
                width: 230,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: const Center(child: Text("Hello")),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
