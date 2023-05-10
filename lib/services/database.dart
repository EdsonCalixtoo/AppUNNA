import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/comment.dart';
import '../models/category.dart';
import '../models/post.dart';
import '../models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("unna-users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "role": user.role,
        'userImage':
            'https://eu.ui-avatars.com/api/?name=${user.name}&background=random',
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("unna-users").doc(uid).get();

      return UserModel.fromMap(_doc as DocumentSnapshot<Map<String, dynamic>>);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      await _firestore
          .collection("unna-users")
          .doc(uid)
          .collection("todos")
          .add({
        'dateCreated': Timestamp.now().millisecondsSinceEpoch,
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> uploadPictureGetUrl(var arquivoEnviar) async {
    print("\n\n** Database uploadPictureGetUrl ");

    // enviando arquivo para o fireStore (pasta categoria/produtcId)
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("unnaImagens")
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(arquivoEnviar);

    TaskSnapshot s = await uploadTask.whenComplete(() => {});
    String downloadUrl = await s.ref.getDownloadURL();

    print("downloadUrl=" + downloadUrl);

    print("TERMINOU");
    return downloadUrl;
  } //uploadFotoPerfil

  // CATEGORIES ###########################################################################################
  // ################################################################################################

  Future<void> addCategory(Map<String, dynamic> content) async {
    try {
      await _firestore.collection("unna-categories").add(content);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> editCategory(Map<String, dynamic> content) async {
    try {
      await _firestore
          .collection("unna-categories")
          .doc(content['id'])
          .update(content);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> resultado = [];
    QuerySnapshot categories;

    try {
      // make reference to collections
      CollectionReference postQuery = _firestore.collection('unna-categories');
      categories = await postQuery.orderBy('order', descending: false).get();

      if (categories.docs.isNotEmpty) {
        print('\n getPosts: there is data');
        categories.docs.forEach((doc) {
          resultado.add(CategoryModel.fromMap(
              doc as DocumentSnapshot<Map<String, dynamic>>));
        });
      }

      return resultado;
    } catch (e) {
      print(e);
      rethrow;
    }
  } //getCategories

  // COMMENTS ###########################################################################################
  // ################################################################################################

  Future<void> addComment(Map<String, dynamic> content) async {
    try {
      await _firestore.collection("unna-comments").add(content);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<CommentModel>> getComments({required String postId}) async {
    List<CommentModel> resultado = [];
    QuerySnapshot comments;

    try {
      // make reference to collections
      CollectionReference commentsQuery =
          _firestore.collection('unna-comments');

      comments = await commentsQuery
          .where('postId', isEqualTo: postId)
          .limit(100)
          .orderBy('dateCreatedAt', descending: false)
          .get();

      if (comments.docs.isNotEmpty) {
        comments.docs.forEach((doc) {
          resultado.add(CommentModel.fromMap(
              doc as DocumentSnapshot<Map<String, dynamic>>));
        });
      }

      return resultado;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void incrementCommentCount(String postId) {
    // not async since is not important
    try {
      _firestore
          .collection("unna-posts")
          .doc(postId)
          .update({"commentCount": FieldValue.increment(1)});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void deleteComment(String postId, String commentId) {
    // not async since is not important
    try {
      _firestore.collection("unna-comments").doc(commentId).delete();

      _firestore
          .collection("unna-posts")
          .doc(postId)
          .update({"commentCount": FieldValue.increment(-1)});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // POSTS ###########################################################################################
  // ################################################################################################

  Future<List<PostModel>> getPosts(
      {Timestamp? startDate,
      int? quantity,
      bool isRefresh = false,
      required String selectedFilter,
      String? userId}) async {
    List<PostModel> resultado = [];
    QuerySnapshot posts;

    try {
      // make reference to collections
      CollectionReference postQuery = _firestore.collection('unna-posts');

      // refresh there is no limit
      print('\n\n --- getPosts(Database): isRefresh: ' +
          isRefresh.toString() +
          ' quantity:' +
          quantity.toString() +
          ' startDate: ' +
          startDate.toString() +
          ' selectedFilter: ' +
          selectedFilter);

      if (isRefresh) {
        print(' --- isRefresh ');

        if (startDate != null) {
          // if (selectedFilter == 'geral') {
          //   posts = await postQuery.where('createdAt', isGreaterThan: startDate).orderBy('createdAt', descending: true).get();
          // } else {
          //   posts = await postQuery.where('category', isEqualTo: selectedFilter).where('createdAt', isGreaterThan: startDate).orderBy('createdAt', descending: true).get();
          // }

          switch (selectedFilter) {
            case 'geral':
              posts = await postQuery
                  .where('createdAt', isGreaterThan: startDate)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            case 'meus_likes':
              // print(' --- CAI AQUI CARALHOqqq userId=' + userId.toString());
              posts = await postQuery
                  .where('likes', arrayContains: userId)
                  .where('createdAt', isGreaterThan: startDate)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            case 'posts_profile_user':
              print(' --- CAI AQUI CARALHO posts_profile_user userId=' +
                  userId.toString());
              posts = await postQuery
                  .where('userHandle', isEqualTo: userId)
                  .where('createdAt', isGreaterThan: startDate)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            default:
              posts = await postQuery
                  .where('category', isEqualTo: selectedFilter)
                  .where('createdAt', isGreaterThan: startDate)
                  .orderBy('createdAt', descending: true)
                  .get();
          }
        } else {
          // if (selectedFilter == 'geral') {
          //   posts = await postQuery.orderBy('createdAt', descending: true).get();
          // } else {
          //   posts = await postQuery.where('category', isEqualTo: selectedFilter).orderBy('createdAt', descending: true).get();
          // }

          switch (selectedFilter) {
            case 'geral':
              posts =
                  await postQuery.orderBy('createdAt', descending: true).get();
              break;
            case 'meus_likes':
              print(' --- CAI AQUI CARALHOOOO userId=' + userId.toString());
              posts = await postQuery
                  .where('likes', arrayContains: userId)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            default:
              posts = await postQuery
                  .where('category', isEqualTo: selectedFilter)
                  .orderBy('createdAt', descending: true)
                  .get();
          }
        }
      } else {
        if (startDate != null) {
          switch (selectedFilter) {
            case 'geral':
              posts = await postQuery
                  .where('createdAt', isLessThan: startDate)
                  .limit(quantity ?? 100000)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            case 'meus_likes':
              print(' --- CAI AQUI CARALHO-- userId=' + userId.toString());
              posts = await postQuery
                  .where('likes', arrayContains: userId)
                  .where('createdAt', isLessThan: startDate)
                  .limit(quantity ?? 100)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            case 'posts_profile_user':
              print(' --- CAI AQUI CARALHO posts_profile_user -- userId=' +
                  userId.toString());
              posts = await postQuery
                  .where('userHandle', isEqualTo: userId)
                  .where('createdAt', isLessThan: startDate)
                  .limit(quantity ?? 100)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            default:
              posts = await postQuery
                  .where('category', isEqualTo: selectedFilter)
                  .where('createdAt', isLessThan: startDate)
                  .limit(quantity ?? 100)
                  .orderBy('createdAt', descending: true)
                  .get();
          }
        } else {
          switch (selectedFilter) {
            case 'geral':
              posts = await postQuery
                  .limit(quantity ?? 100)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            case 'meus_likes':
              print(' --- selectedFilter=$selectedFilter userId=' +
                  userId
                      .toString()); // limit(quantity).orderBy('createdAt', descending: true)
              posts = await postQuery
                  .limit(quantity ?? 100)
                  .where('likes', arrayContains: userId)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            case 'posts_profile_user':
              print(' --- selectedFilter=$selectedFilter userId=' +
                  userId
                      .toString()); // limit(quantity).orderBy('createdAt', descending: true)
              posts = await postQuery
                  .limit(quantity ?? 100)
                  .where('userHandle', isEqualTo: userId)
                  .orderBy('createdAt', descending: true)
                  .get();
              break;
            default:
              posts = await postQuery
                  .where('category', isEqualTo: selectedFilter)
                  .limit(quantity ?? 100)
                  .orderBy('createdAt', descending: true)
                  .get();
          }
        }
      }

      if (posts.docs.isNotEmpty) {
        print(' --- getPosts(Database):  getPosts: there is data');
        posts.docs.forEach((doc) {
          resultado.add(
              PostModel.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>));
        });
      } else {
        print(' --- getPosts(Database): getPosts: there is NO data');
      }

      return resultado;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addPost(Map<String, dynamic> content) async {
    try {
      await _firestore.collection("unna-posts").add(content);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> editPost(Map<String, dynamic> content) async {
    try {
      await _firestore
          .collection("unna-posts")
          .doc(content['id'])
          .update(content);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // USER/LIKE ######################################################################################
  // ################################################################################################

  Future<void> editUserProfile(Map<String, dynamic> content) async {
    try {
      await _firestore
          .collection("unna-users")
          .doc(content['id'])
          .update(content);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> removeLike(String userId, String postId) async {
    try {
      await _firestore.collection("unna-users").doc(userId).update({
        "likes": FieldValue.arrayRemove([postId])
      });

      await _firestore.collection("unna-posts").doc(postId).update({
        "likeCount": FieldValue.increment(-1),
        "likes": FieldValue.arrayRemove([userId])
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addLike(String userId, String postId) async {
    try {
      await _firestore.collection("unna-users").doc(userId).update({
        "likes": FieldValue.arrayUnion([postId])
      });

      await _firestore.collection("unna-posts").doc(postId).update({
        "likeCount": FieldValue.increment(1),
        "likes": FieldValue.arrayUnion([userId])
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // CONTROLE/BULK ######################################################################################
  // ################################################################################################

  Future<bool> createNewElement(String table, var element) async {
    try {
      await _firestore.collection(table).add(element);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> cleanTable(String table) async {
    try {
      QuerySnapshot _query = await _firestore.collection(table).get();

      print('_query:' + _query.docs.isEmpty.toString());
      print('cleanTable: ' + _query.docs.length.toString());

      _query.docs.forEach((doc) {
        print(doc.id + ' - ' + doc["body"]);

        _firestore.collection(table).doc(doc.id).delete();
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // USUARIO/PROFILE ######################################################################################
  // ################################################################################################

  Future<Map<String, dynamic>> userProfileData(String userID) async {
    String userId;
    int postCount = 0;
    int likeCount = 0;
    int commentCount = 0;

    try {
      // step 1. get userId
      DocumentSnapshot _user =
          await _firestore.collection("unna-users").doc(userID).get();

      if (_user.exists) {
        userId = _user.id;
        print('userId=' + userId.toString());

        // step 2. get posts count
        QuerySnapshot _queryPosts = await _firestore
            .collection("unna-posts")
            .where('userHandle', isEqualTo: userID)
            .get();
        postCount = _queryPosts.docs.length;
        print('qtdePosts=' + _queryPosts.docs.length.toString());

        // step 2. get comments count
        QuerySnapshot _queryComments = await _firestore
            .collection("unna-comments")
            .where('userHandle', isEqualTo: userID)
            .get();
        commentCount = _queryComments.docs.length;
        print('commentCount=' + _queryComments.docs.length.toString());

        // step 3. get like count
        QuerySnapshot _queryLikes = await _firestore
            .collection("unna-posts")
            .where('likes', arrayContains: userId)
            .get();
        likeCount = _queryLikes.docs.length;
        print('likeCount=' + _queryLikes.docs.length.toString());
      }

      return {
        'postCount': postCount,
        'likeCount': likeCount,
        'commentCount': commentCount,
      };
    } catch (e) {
      print(e);
      // rethrow;
      return {
        'postCount': postCount,
        'likeCount': likeCount,
        'commentCount': commentCount,
      };
    }
  }
}
