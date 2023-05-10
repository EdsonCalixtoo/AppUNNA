import 'package:get/get.dart';
import '../userController.dart';
import '../navController.dart';
import '../categoryController.dart';
import '../authController.dart';
import '../postController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<NavController>(NavController(), permanent: true);
    Get.put<PostController>(PostController(), permanent: true);

    Get.put<CategoryController>(CategoryController(), permanent: true);
     
  }
}
