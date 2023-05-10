import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/postController.dart';
import '../controllers/userController.dart';
import '../controllers/navController.dart';
import '../screens/category_filter.dart';
import '../screens/home.dart';
import '../screens/post_add_edit.dart';
import '../screens/user_profile.dart';
import '../utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  final NavController navController = Get.put(NavController());
  final UserController userController = Get.put(UserController());

  Widget centralButton(NavController nav, Function execute) {
    return GestureDetector(
      onTap: () {
        nav.selectedIndex = -1;
        execute();
      },
      child: Container(
        width: 70,
        height: 45,
        decoration: new BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 35.0,
              offset: Offset(1, 15.75),
            )
          ],
          color: corPrimaria,
          borderRadius: new BorderRadius.all(Radius.circular(40.0)),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }

  Widget iconElement(int index, int indexSelected, IconData icon,
      Function execute, NavController nav) {
    return GestureDetector(
      onTap: () {
        if (nav.selectedIndex == index) return;

        nav.selectedIndex = index;
        execute();
      },
      child: Icon(icon,
          color: index != indexSelected ? Colors.black38 : Colors.black,
          size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 35.0,
            offset: Offset(1, 15.75),
          )
        ],
        color: Colors.white,
        borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      height: 80,
      width: double.infinity,
      child: Obx(() => Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              iconElement(
                  0, navController.selectedIndex, Icons.widgets_outlined, () {
                Get.find<PostController>().updateFilter('geral', '');
                Get.offAll(Home());
              }, navController),
              iconElement(1, navController.selectedIndex, Icons.filter_alt,
                  () => Get.offAll(CategoryFilterScreen()), navController),
              centralButton(navController, () => Get.to(PostAddEditScreen())),
              iconElement(
                  2, navController.selectedIndex, Icons.favorite_outline, () {
                Get.find<PostController>()
                    .updateFilter('meus_likes', userController.user.id!);
                Get.offAll(Home());
              }, navController),
              iconElement(3, navController.selectedIndex, Icons.person_outline,
                  () => Get.offAll(UserProfileScreen()), navController),
            ],
          ))),
    );
  }
}
