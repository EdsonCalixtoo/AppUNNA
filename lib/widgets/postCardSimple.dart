import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/postController.dart';
import '../screens/post_comment.dart';
import '../controllers/userController.dart';
import 'likeButton.dart';
import '../models/post.dart';

// ignore: must_be_immutable
class PostCardSimple extends StatelessWidget {
  final PostModel post;

  PostCardSimple({Key? key, required this.post}) : super(key: key);

  PostController postController = Get.find<PostController>();

  Widget imagePost(BuildContext context, String? urlImagem) {
    var widtSize = MediaQuery.of(context).size.width * 0.7;

    return GestureDetector(
      onTap: () {
        Get.to(PostCommentScreen(), arguments: post);
      },
      child: Container(
        height: widtSize,
        margin: EdgeInsets.all(0),
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(urlImagem != null
                ? urlImagem
                : 'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/zSocialImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c'),
            fit: BoxFit.cover,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 35.0,
              offset: Offset(1, 15.75),
            )
          ],
          color: Colors.blue,
          borderRadius: new BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget textBody() {
    return post.body != ''
        ? Row(
            children: [
              Expanded(
                child: Container(
                  // color: Colors.blue,
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Text(
                    DateFormat('dd.MM hh:mm')
                            .format(post.createdAt!.toDate())
                            .toString() +
                        ': ' +
                        post.body!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget baseLine(bool isLiked, Function onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 90,
                      // color: Colors.green,
                      child: Row(
                        children: [
                          LikeButton(
                              isLiked: isLiked == true, onTap: () => onTap()),
                          Expanded(
                            child: Text(
                              post.likeCount! > 0
                                  ? post.likeCount.toString()
                                  : '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      width: 70,
                      // color: Colors.yellow,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(PostCommentScreen(), arguments: post);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              post.commentCount! > 0
                                  ? Icons.sms_outlined
                                  : Icons.chat_bubble_outline,
                              size: 25,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 11),
                            Expanded(
                              child: Text(
                                post.commentCount! > 0
                                    ? post.commentCount.toString()
                                    : '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ],
            ),
          ),
          Container(
              height: 50,
              // color: Colors.green,
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      post.category!,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Icon(
                    Icons.flag_outlined,
                    size: 28,
                    color: Colors.black54,
                  )
                ],
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // PostController _postController = Get.find<PostController>();
    // UserController _userController = Get.find<UserController>();

    // void onClickLike() {
    //   userController.toggleLike(post.id);
    // }

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(25.0)),
      ),
      // color: Colors.blue,
      // height: 500,
      child: Column(
        children: [
          // SizedBox(height: 2),
          imagePost(context, post.postImage!),
          textBody(),
          GetX<UserController>(
              // init: Get.put<CourseController>(CourseController()),
              builder: (UserController userController) {
            // List<String> tempLikes = new List<String>.from(userController.likes);

            return baseLine(post.likes!.contains(userController.user.id), () {
              postController.toggleLike(userController.user.id!, post);

              // if (tempLikes.contains(post.id) == true) {
              //   post.likeCount--;
              // } else {
              //   post.likeCount++;
              // }
            });
          }),
        ],
      ),
    );
  }
}
