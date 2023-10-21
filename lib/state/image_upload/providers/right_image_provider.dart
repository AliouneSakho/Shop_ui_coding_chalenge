import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart'
    show AssetImage, FileImage, ImageProvider;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart' show CroppedFile;
import 'package:plants_ui/state/image_upload/typedefs/image_provider.dart';

final imageProvider =
    StateProvider.family<ImageProvider, ImageSource>((ref, source) {
  assert(source is CroppedFile || source is AssetImage || source is Url);
  late ImageProvider imageProvider;

  switch (source.runtimeType) {
    case CroppedFile:
      imageProvider = FileImage(
        File((source as CroppedFile).path),
      );
      break;
    case AssetImage:
      imageProvider = AssetImage((source as AssetImage).assetName);
      break;
    case Url:
      imageProvider = CachedNetworkImageProvider(source);
      break;
  }
  return imageProvider;
});
