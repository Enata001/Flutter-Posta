import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:posta/utils/constants.dart';
import 'package:posta/utils/firebase_fields.dart';
import 'package:posta/utils/typedefs.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageMethods {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadPicture(
      {String name = FirebaseFields.users,
      bool isPost = false,
      Uint8List? file,
      required UserId userId}) async {
    String photoLink = Constants.profileLink;
    try {
      final ref = _storage.ref().child(name).child(userId);
      if (isPost) {
        final id = const Uuid().v4();
        ref.child(id);
      }

      if (file != null) {
        photoLink = await ref.putData(file).snapshot.ref.getDownloadURL();
      }
      return photoLink;
    } on Exception {
      return Constants.profileLink;
    }
  }
}
