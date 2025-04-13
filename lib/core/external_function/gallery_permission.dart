import 'package:permission_handler/permission_handler.dart';

Future<bool> requestGalleryPermission() async {
  // For Android 13+ you can request specific media access
  if (await Permission.photos.request().isGranted ||
      await Permission.storage.request().isGranted) {
    return true;
  } else {
    return false;
  }
}