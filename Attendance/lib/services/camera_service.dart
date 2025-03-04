// import 'package:image_picker/image_picker.dart';
// // import 'dart:io';

// class CameraService {
//   final ImagePicker _picker = ImagePicker();

//   Future<XFile?> openCamera() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);

//     if (image != null) {
//       print('Image Path: ${image.path}');
//     } else {
//       print('No image captured.');
//     }

//     return image; // Return the captured image
//   }
// }
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear, // Opens the rear camera by default
      );

      if (image != null) {
        print('Image Path: ${image.path}');
      } else {
        print('No image captured.');
      }

      return image;
    } catch (e) {
      print('Error opening camera: $e');
      return null;
    }
  }
}
