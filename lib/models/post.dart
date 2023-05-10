// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? body;
  String? category;
  String? userName;
  String? userHandle;
  String? userImage;
  String? postImage;
  String? id;
  int? commentCount;
  int? likeCount;
  Timestamp? createdAt;
  List<String>? likes = [];
  PostModel({
    this.body,
    this.category,
    this.userName,
    this.userHandle,
    this.userImage,
    this.postImage,
    this.id,
    this.commentCount,
    this.likeCount,
    this.createdAt,
    this.likes,
  });

  @override
  String toString() {
    return 'PostModel(id: $id, body: $body, category: $category, userName: $userName, userHandle: $userHandle, userImage: $userImage, postImage: $postImage, id: $id, commentCount: $commentCount, likeCount: $likeCount, createdAt: $createdAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'category': category,
      'userName': userName,
      'userHandle': userHandle,
      'userImage': userImage,
      'postImage': postImage,
      'id': id,
      'commentCount': commentCount,
      'likeCount': likeCount,
      'createdAt': createdAt != null ? createdAt!.millisecondsSinceEpoch : null,
      'likes': likes,
    };
  }

  factory PostModel.fromMap(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  ) {
    return PostModel(
        id: documentSnapshot.id,
        body: documentSnapshot.data()!["body"],
        category: documentSnapshot.data()!["category"],
        userName: documentSnapshot.data()!["userName"],
        userImage: documentSnapshot.data()!["userImage"],
        postImage: documentSnapshot.data()!["postImage"],
        userHandle: documentSnapshot.data()!["userHandle"],
        commentCount: documentSnapshot.data()!["commentCount"],
        likeCount: documentSnapshot.data()!["likeCount"],
        createdAt: documentSnapshot.data()!["createdAt"],
        likes: documentSnapshot.data()!['likes'] != null
            ? List<String>.from((documentSnapshot.data()!['likes']))
            : []);
  }

  String toJson() => json.encode(toMap());
}
