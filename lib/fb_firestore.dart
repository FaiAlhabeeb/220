
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hemmah/contex_extenssion.dart';
import 'package:hemmah/post.dart';

import 'firebase_helper.dart';



class FbFirestoreController with FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> create(Post post, BuildContext context) async {
    _firestore
        .collection('Posts')
        .add(post.toMap())
        .then((value) => context.showSnackBar(
        message: successResponse.message, error: false))
        .catchError((error) => context.showSnackBar(
        message: errorResponse.message, error: true));
  }
}