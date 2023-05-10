import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/authController.dart';
// import '../controllers/courseController.dart';
import '../controllers/userController.dart';
import '../screens/home.dart';
import '../screens/login.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (Get.find<AuthController>().user != null) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}


/*class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
        // Get.put<CourseController>(CourseController(), permanent: true);
      },
      builder: (_) {
        if (Get.find<AuthController>().user != null) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}*/
