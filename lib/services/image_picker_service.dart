import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  // Returns a [File] object pointing to the image that was picked.
  Future<File> pickImage({@required ImageSource source}) async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    File _image;
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    } else {
      print('No image selected.');
      return null;
    }
  }
}
