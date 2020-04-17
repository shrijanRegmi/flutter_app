import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  StorageReference _storage = FirebaseStorage.instance
      .ref()
      .child("Items")
      .child(DateTime.now().toString());

  Future uploadImg(final File _img, final Function _function) async {
    try {
      StorageUploadTask _uploadTask = _storage.putFile(_img);
      await _uploadTask.onComplete;
      _storage.getDownloadURL().then((url) {
        _function(url);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
