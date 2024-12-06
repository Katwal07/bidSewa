import 'package:image_picker/image_picker.dart';

abstract class MultipleImagePickerState {}

class ImageInitialState extends MultipleImagePickerState {}

class ImageLoadingState extends MultipleImagePickerState {}

class ImageLoadedState extends MultipleImagePickerState {
  final List<String>? originalName;
  final List<String>? displayName;
  final List<XFile> file;

  ImageLoadedState({this.originalName,this.displayName, required this.file});

  List<String> get imagePath => file.map((e)=> e.path).toList();

}

class FailureImageLoaded extends MultipleImagePickerState {
  final String errorMessage;

  FailureImageLoaded({required this.errorMessage});
}
