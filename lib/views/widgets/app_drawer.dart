import 'package:catering_service_adming/constant.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(color: ColorConstant.secondaryColor),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-icon/user_318-159711.jpg'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Admin',
                    style: AppTextStyle.normalText(fontSize: 22),
                  ),
                  Text(
                    'admin@gmail.com',
                    style: AppTextStyle.normalText(
                        fontSize: 12, color: ColorConstant.blackColor),
                  ),
                ],
              )),
          Column(
            children: [
              ListTile(
                leading: const Icon(Iconsax.home),
                title: Text(
                  "Home",
                  style: AppTextStyle.normalText(),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'home');
                },
              ),
              ListTile(
                leading: const Icon(Iconsax.discover),
                title: Text(
                  "Order",
                  style: AppTextStyle.normalText(),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'home');
                },
              ),
              ListTile(
                leading: const Icon(Iconsax.category_2),
                title: Text(
                  "Categories",
                  style: AppTextStyle.normalText(),
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.pushNamed(context, 'normalPoll');
                },
              ),
              ListTile(
                leading: const Icon(Iconsax.image),
                title: Text(
                  "Slider Upload",
                  style: AppTextStyle.normalText(),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'surveyPoll');
                },
              ),
              ListTile(
                leading: const Icon(Iconsax.like_shapes),
                title: Text(
                  "Products",
                  style: AppTextStyle.normalText(),
                ),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const AboutUsPage(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
