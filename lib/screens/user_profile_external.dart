import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/appbar_profile.dart';
import '../widgets/postCardSimple.dart';
import '../utils/colors.dart';
import '../controllers/userController.dart';
import '../controllers/postController.dart';

class ProfileExternalScreen extends StatefulWidget {
  @override
  _ProfileExternalScreenState createState() => _ProfileExternalScreenState();
}

class _ProfileExternalScreenState extends State<ProfileExternalScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        final UserController userController = Get.put(UserController());

        Get.find<PostController>()
            .getMore(quantity: 10, userId: userController.user.id!);
      }
    });

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundoClara,
      appBar: AppBarProfile(
        height: 280,
        userHandle: Get.arguments['userHandle'],
        userImage: Get.arguments['userImage'],
        userName: Get.arguments['userName'],
      ),
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: 40,
            width: 35,
            child: Container(),
            color: corPrimaria,
          ),
          Container(
            height: 40,
            width: 35,
            decoration: BoxDecoration(
                color: corFundoClara,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  // bottomRight: Radius.circular(40),
                )),
            child: Container(),
          ),
          GetX<PostController>(
            // init: Get.put<PostController>(PostController()),
            init: Get.find<PostController>(),
            builder: (PostController? postController) {
              if (postController != null && postController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(corPrimariaClara)),
                );
              } else {
                if (postController != null) {
                  print(' --- postController.postListUserProfile.length=' +
                      postController.postListUserProfile.length.toString());
                }

                if (postController != null &&
                    postController.postListUserProfile.length != 0) {
                  return ListView.builder(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 10),
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: postController.postListUserProfile.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new PostCardSimple(
                            post: postController.postListUserProfile[index]);
                      });
                } else {
                  print(' --- CAIU AQUI');
                  return Center(child: Text('nenhum post no momento'));
                }
              }
            },
          ),
          // Container(
          //   height: 40,
          //   width: 40,
          //   decoration: BoxDecoration(
          //       color: Colors.purple,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(40),
          //         bottomRight: Radius.circular(40),
          //       )),
          //   child: Container(),
          // ),
          // Container(
          //   height: 30,
          //   width: 30,
          //   child: Container(),
          // ),
        ],
      ),
      // bottomNavigationBar: CustomNavBar()
    );
  }
}
