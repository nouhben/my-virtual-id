import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  // Returns a [File] object pointing to the image that was picked.
  Future<File> pickImage(@required ImageSource _source) async {
    final pickedImage = await _imagePicker.getImage(source: _source);
    return File(pickedImage.path);
  }
}
