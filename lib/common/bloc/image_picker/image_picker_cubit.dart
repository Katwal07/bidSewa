import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepa_bid/common/bloc/image_picker/image_picker_state.dart';

class MultipleImagePickerCubit extends Cubit<MultipleImagePickerState> {
  MultipleImagePickerCubit() : super(ImageInitialState());

  String _truncateFileName(String fileName, {int maxLength = 10}) {
    if (fileName.length <= maxLength) return fileName;

    /// keep the first name and the extension
    final extension = fileName.split('.').last;
    final nameWithoutExt = fileName.substring(0, fileName.lastIndexOf('.'));
    final truncatedName =
        nameWithoutExt.substring(0, maxLength - extension.length - 3);

    return '$truncatedName...$extension';
  }

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> selectedImage = [];

  Future<void> pickImage() async {
    try {
      final pickedImage = await _imagePicker.pickMultiImage();

      selectedImage.addAll(pickedImage);

      final truncatedName = pickedImage.map((e) {
        final fileName = e.name;
        return _truncateFileName(fileName);
      }).toList();

      emit(ImageLoadedState(
          file: pickedImage,
          originalName: truncatedName,
          displayName: truncatedName));
    } catch (e) {
      emit(FailureImageLoaded(errorMessage: e.toString()));    }
  }

  void reset(int index) {
    if (index >= 0 && index < selectedImage.length) {
      selectedImage.removeAt(index);
      if (selectedImage.isEmpty) {
        emit(ImageInitialState());
      } else {
        emit(ImageLoadedState(file: selectedImage));
      }
    }
  }

  List<String>? getSelectedImagePath() {
    final currentState = state;
    if (currentState is ImageLoadedState) {
      return currentState.imagePath;
    }
    return null;
  }
}
