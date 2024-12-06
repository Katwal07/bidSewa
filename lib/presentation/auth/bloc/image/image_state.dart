import 'package:image_picker/image_picker.dart';

abstract class ImagePickerState {}

class ImageInitialState extends ImagePickerState {}

class ImageLoadingState extends ImagePickerState {}

class ImageLoadedState extends ImagePickerState {
  final String originalName;
  final String displayName;
  final XFile file;

  ImageLoadedState({required this.originalName, required this.displayName, required this.file});

  String get imagePath => file.path;

}

class FailureImageLoaded extends ImagePickerState {
  final String errorMessage;

  FailureImageLoaded({required this.errorMessage});
}