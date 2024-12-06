import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class VideoPickerState {}

class VideoPickerInitial extends VideoPickerState{}

class VideoPickerLoading extends VideoPickerState{}

class VideoPickerLoaded extends VideoPickerState{
  final List<XFile> file;
  final List<File> thumbnailFile;

  VideoPickerLoaded({required this.file, required this.thumbnailFile});



  List<String> get videoPath => file.map((e)=> e.path).toList();

  List<String> get videoThumbnail => file.map((e)=> e.path).toList();
}

class VideoPickerFailure extends VideoPickerState{
  final String errorMessage;

  VideoPickerFailure({required this.errorMessage});
}