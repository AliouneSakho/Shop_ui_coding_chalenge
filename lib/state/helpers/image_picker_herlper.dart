import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Color, Colors;
import 'package:flutter/services.dart' show PlatformException;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

@immutable
class ImagePickerHelper {
  static Future<CroppedFile?> pickImage() async {
    XFile? pickedImage;
    CroppedFile? croppedFile;

    try {
      pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 60);
      if (pickedImage == null) {
        return null;
      }

      croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Editer Image',
            toolbarColor: const Color.fromARGB(255, 0, 23, 43),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          )
        ],
      );
    } on PlatformException {
      //
    }
    return croppedFile!;
  }
}
