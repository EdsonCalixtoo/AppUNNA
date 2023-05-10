import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navController.dart';
import '../screens/user_profile.dart';
import '../controllers/userController.dart';
import '../utils/colors.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController _userController = Get.find<UserController>();

    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                // height: 55,
                // color: Colors.green,
                // child: Text("Moagrama", style: TextStyle(fontFamily: 'Roboto', fontSize: 35)),
                // child: Image.asset(
                //                 'assets/images/logo.png',
                //                 height: 40,
                //                 // width: 40,
                //                 // color: Colors.white,
                //                 // colorBlendMode: BlendMode.darken,
                //                 fit: BoxFit.fitHeight,
                //               )
                child: Row(children: [
              Text("U",
                  style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
              Text("N",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: corSecundaria)),
              Text("N",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: corPrimaria)),
              Text("A",
                  style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
            ])),
            GestureDetector(
                onTap: () {
                  //Get.lazyPut(()=>NavController())
                  Get.find<NavController>().selectedIndex = 3;
                  Get.offAll(UserProfileScreen());
                },
                child: _userController.user.userImage != null
                    ? CircleAvatar(
                        radius: 14.0,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 12.0,
                          backgroundImage: appBarimage(),
                        ),
                      )
                    : Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 30,
                      ))
          ],
        ),
      ),
    );
  }

  ImageProvider appBarimage() {
    UserController _userController = Get.find<UserController>();
    if (_userController.user.userImage == null) {
      return AssetImage("images/person.jpg");
    }
    return NetworkImage(_userController.user.userImage!);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
