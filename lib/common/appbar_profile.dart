import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/userController.dart';
import '../utils/colors.dart';

class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final String userImage;
  final String userHandle;
  final String userName;

  AppBarProfile(
      {Key? key,
      this.height,
      required this.userImage,
      required this.userHandle,
      required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserController _userController = Get.find<UserController>();

    Get.find<UserController>().getUserProfileNumbers(this.userHandle);

    Widget userInfoDetail(String info, String number) {
      return Column(
        children: [
          Text(number,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text(info,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
        ],
      );
    }

    Widget circularLoadingSecundary() {
      return Container(
          height: 20,
          width: 20,
          child: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(corSecundaria)),
          ));
    }

    Widget userAvatar() {
      return Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 17.0,
              offset: Offset(0, 12),
              spreadRadius: 1,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: this.userImage,
            height: 81.0,
            width: 81.0,
            fit: BoxFit.cover,
          ),
        ),
      );

      // ? CircleAvatar(
      //     radius: 36.0,
      //     backgroundColor: Colors.black,
      //     child: CircleAvatar(
      //       backgroundColor: Colors.grey[300],
      //       radius: 34.0,
      //       backgroundImage: this.userImage == null ? AssetImage("images/person.jpg") : NetworkImage(_userController.user.userImage),
      //     ),
      //   )
      // : Icon(
      //     Icons.person_outline,
      //     color: Colors.black,
      //     size: 30,
      //   );
    }

    Widget userName(String name) {
      return Stack(
        children: [
          Container(color: corPrimaria, height: 155, child: Container()),
          Container(
            decoration: BoxDecoration(
                color: corFundoClara,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                )),
            height: 155,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userAvatar(),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(this.userName,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget userInfo() {
      return Container(
        decoration: BoxDecoration(
            color: corPrimaria,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            )),
        height: 89,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            GetX<UserController>(
              // init: UserController(),
              initState: (userController) {
                print('rodei initState do elemento la de dados');
                // userController.getUserProfileNumbers('edson@unna.com');
              },
              builder: (userController) {
                return userController.isLoading.value == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          circularLoadingSecundary(),
                          circularLoadingSecundary(),
                          circularLoadingSecundary()
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          userInfoDetail(
                              'POSTS',
                              userController.userProfileData['postCount']
                                  .toString()),
                          userInfoDetail(
                              'LIKES',
                              userController.userProfileData['likeCount']
                                  .toString()),
                          userInfoDetail(
                              'COMMENTS',
                              userController.userProfileData['commentCount']
                                  .toString()),
                        ],
                      );
              },
            )
          ],
        ),
      );
    }

    return Container(
      height: height,
      color: corFundoClara.withAlpha(140),
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 10),
              // Text(this.userName, style: TextStyle(fontSize: 26, fontWeight: FontWeight.normal)),
              userName(this.userName),
              // SizedBox(height: 20),
              userInfo(),
              // bottomCurve()
            ],
          ),
          Positioned(
            left: 5,
            top: 20,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.chevron_left_outlined,
                size: 40,
                color: corSecundaria,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
