// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String body;
  String userHandle;
  String userImage;
  String id;
  String postId;
  String userName;
  Timestamp? dateCreatedAt;
  CommentModel({
    required this.body,
    required this.userHandle,
    required this.userImage,
    required this.id,
    required this.postId,
    required this.userName,
    required this.dateCreatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'userHandle': userHandle,
      'userImage': userImage,
      'id': id,
      'postId': postId,
      'userName': userName,
      'dateCreatedAt': dateCreatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CommentModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return CommentModel(
      body: documentSnapshot.data()!['body'] as String,
      userHandle: documentSnapshot.data()!['userHandle'] as String,
      userImage: documentSnapshot.data()!['userImage'] as String,
      id: documentSnapshot.id as String,
      postId: documentSnapshot.data()!['postId'] as String,
      userName: documentSnapshot.data()!['userName'] as String,
      dateCreatedAt: documentSnapshot.data()!['dateCreatedAt'],
    );
  }

  String toJson() => json.encode(toMap());
}
