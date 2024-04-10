import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:posta/models/user_model.dart';
import 'package:posta/utils/firebase_fields.dart';

class FirestoreMethods {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<bool> storeUserInfo({required UserModel user}) async {
    try {
      final userInfo = await _store
          .collection(FirebaseFields.users)
          .where(
            FirebaseFields.userId,
            isEqualTo: user.userId,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isEmpty) {
        await _store
            .collection(FirebaseFields.users)
            .doc(user.userId)
            .update(user.toMap());
      } else {
        await _store
            .collection(FirebaseFields.users)
            .doc(user.userId)
            .set(user.toMap());
      }
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> checkEmail({required String email}) async {
    final result = await _store
        .collection(FirebaseFields.users)
        .where(
          FirebaseFields.email,
          isEqualTo: email,
        )
        .get();
    if (result.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
