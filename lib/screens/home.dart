import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/customNavBar.dart';
import '../common/appbar_home.dart';
import '../utils/colors.dart';
import '../widgets/postCard.dart';
import '../controllers/userController.dart';
import '../controllers/postController.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scrollController = ScrollController();
  String selectedFilter = 'geral';

  // PostController postController. = Get.find<PostController>();

  @override
  void initState() {
    if (Get.arguments != null) {
      print('\n\n\n -----------------');
      print(Get.arguments);
      selectedFilter = Get.arguments as String;
    } else {
      Get.find<UserController>().init();
    }

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

  //  quando esta filtrando, aparecer no topo categoria com um X para remover filtro.

  //  comment count nao ta incrementando ao adicionar comentario em uma postagem NOVA (nem nas velhas parece)

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserController _userController = Get.find<UserController>();

    return Scaffold(
        backgroundColor: corFundoClara,
        appBar: AppBarHome(),
        extendBody: false,
        extendBodyBehindAppBar: true,
        body: GetX<PostController>(
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
                print(' --- postController.postList.length=' +
                    postController.postList.length.toString());
              } else {
                print(' --- postController.postList.length = null');
              }

              if (postController != null &&
                  postController.postList.length != 0) {
                return RefreshIndicator(
                    onRefresh: () async {
                      // print(" --- refresh");
                      // print(' --- Maior data:' + postController.postList[postController.postList.length - 1].toString());
                      // print(' --- Mais antigo data:' + postController.postList[postController.postList.length - 1].createdAt.toDate().toString());
                      // print(' --- MAis recente data:' + postController.postList[0].createdAt.toDate().toString());

                      await postController.get(
                          startDate: postController.postList[0].createdAt,
                          quantity: 10,
                          isRefresh: true,
                          userId: _userController.user.id);
                    },
                    child: ListView.builder(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 90),
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: postController.postList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new PostCard(
                              post: postController.postList[index]);
                        }));
              } else {
                print(' --- CAIU AQUI');
                return Center(child: Text('nenhum post no momento'));
              }
            }
          },
        ),
        bottomNavigationBar: CustomNavBar());
  }
}
