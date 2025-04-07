import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../widgets/custom_alert.dart';


final ImagePicker _picker = ImagePicker();
Future<bool?> requestPermission(BuildContext context) async {
  var status = await Permission.photos.request();
  if (status.isGranted) {
    return true;
  } else {

    return await showMyAlert(context , 'Permission Denied', 'Please grant permission to access the gallery from settings.' );
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


