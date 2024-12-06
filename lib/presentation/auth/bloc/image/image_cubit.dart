import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImageInitialState());

  String _truncateFileName(String fileName, {int maxLength = 15}) {
    if (fileName.length <= maxLength) return fileName;

    /// keep the first name and the extension
    final extension = fileName.split('.').last;
    final nameWithoutExt = fileName.substring(0, fileName.lastIndexOf('.'));
    final truncatedName =
        nameWithoutExt.substring(0, maxLength - extension.length - 3);

    return '$truncatedName.$extension';
  }

  final ImagePicker _imagePicker = ImagePicker();
  XFile? selectedImage;

  Future<void> pickImage() async {
    try {
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        selectedImage = pickedImage;
        final fileName = pickedImage.name;
        final truncatedName = _truncateFileName(fileName);

        emit(ImageLoadedState(file: pickedImage, originalName: fileName, displayName: truncatedName));
      } else {
        emit(FailureImageLoaded(errorMessage: "No Image Selected"));
      }
    } catch (e) {
      emit(FailureImageLoaded(errorMessage: e.toString()));
    }
  }

  void reset() {
    selectedImage = null;
    emit(ImageInitialState());
  }

  String? getSelectedImagePath(){
    final currentState = state;
    if( currentState is ImageLoadedState){
      return currentState.imagePath;
    }
    return null;
  }
}