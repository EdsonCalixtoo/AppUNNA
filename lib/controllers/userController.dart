import 'package:get/get.dart';
import '../controllers/authController.dart';
import '../services/database.dart';
import '../models/user.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;
  var likes = [].obs;
  final imageTempUrl = ''.obs;
  final isLoading = false.obs;
  final userProfileData = <String, dynamic>{}.obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void init() async {
    print('UserControle: likes=' + _userModel.value.likes.length.toString());
    _userModel.value =
        await Database().getUser(Get.find<AuthController>().user!.uid);
    _userModel.value.likes.forEach((like) {
      likes.add(like);
    });
  }

  void clear() {
    _userModel.value = UserModel();
  }

  Future<void> edit(
      {required String id,
      required String name,
      required String about,
      required String userImage}) async {
    isLoading.value = true;
    // await Future.delayed(Duration(seconds: 6));
    Database().editUserProfile({
      'id': id,
      'name': name.trim(),
      'about': about.trim(),
      'userImage': userImage != ''
          ? userImage
          : 'https://eu.ui-avatars.com/api/?name=$name&background=random'
    });

    // imageTempUrl.value = '';
    isLoading.value = false;
  }

  Future<String> uploadImageCard(var file) async {
    String res = await Database().uploadPictureGetUrl(file);
    return res;
  }

  Future<void> getUserProfileNumbers(String userHandle) async {
    // loading ON
    isLoading.value = true;

    Map<String, dynamic> userData;

    userData = await Database().userProfileData(userHandle);

    this.userProfileData(userData);

    print('\n\n --- TERMINOU uploadImageCard');

    print(this.userProfileData.toString());

    // loading OFF
    isLoading.value = false;
  }
}
