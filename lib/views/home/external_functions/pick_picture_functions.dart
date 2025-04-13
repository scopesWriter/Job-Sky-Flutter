import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/external_function/gallery_permission.dart';
import '../../../widgets/custom_alert.dart';


final ImagePicker _picker = ImagePicker();
Future<bool?> requestPermission(BuildContext context) async {
  bool isGranted = await requestGalleryPermission();
  if (isGranted) {
    return true;
  } else {

    return await TwoButtonsAlert(context , 'Permission Denied', 'Please grant permission to access the gallery from settings.' );
  }
}
Future<String> pickImage() async {
  print('📷 pickImage called');
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    print('✅ Picked image path: ${image.path}');
    return image.path;
  }
  return '';
}


