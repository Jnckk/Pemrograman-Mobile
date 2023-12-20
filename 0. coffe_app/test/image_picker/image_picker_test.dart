//  RUN => flutter test test/image_picker/image_picker_test.dart

import 'package:coffe_app/controllers/controllers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'image_picker_test.mocks.dart';
// Generate a MockImagePicker using the Mockito package.
@GenerateMocks([ImagePicker])
void main() {
  group('ImagePickerController Tests', () {
    test('Test getImage function', () async {
      final controller = ImagePickerController();
      final mockImagePicker = MockImagePicker();

      // Mock ImagePicker response
      when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => XFile('fake_image_path'));

      await controller.getImage(mockImagePicker);

      // Validate that imagePath is updated
      expect(controller.imagePath.value, 'fake_image_path');
    });

    test('Test getImages function', () async {
      final controller = ImagePickerController();
      final mockImagePicker = MockImagePicker();

      // Mock ImagePicker response
      when(mockImagePicker.pickImage(source: ImageSource.camera))
          .thenAnswer((_) async => XFile('fake_camera_image_path'));

      await controller.getImages(mockImagePicker);

      // Validate that imagePath is updated
      expect(controller.imagePath.value, 'fake_camera_image_path');
    });
  });
}
