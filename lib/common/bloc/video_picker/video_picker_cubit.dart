import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepa_bid/common/bloc/image_picker/image_picker_state.dart';
import 'package:nepa_bid/common/bloc/video_picker/video_picker_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoPickerCubit extends Cubit<VideoPickerState> {
  VideoPickerCubit() : super(VideoPickerInitial());

  final ImagePicker _videoPicker = ImagePicker();
  List<XFile> selectedVideo = [];
  List<File> thumbnailFile = [];
  void pickVideo() async {
    try {
      final XFile? pickedVideo =
          await _videoPicker.pickVideo(source: ImageSource.gallery);

      if (pickedVideo != null) {
        /// Added Selected Video
        selectedVideo.add(pickedVideo);

        /// Generating thumbnail for selected video
        File? thumbnailData = await _generateThumbnail(File(pickedVideo.path));
        if (thumbnailData != null) {
          thumbnailFile.add(thumbnailData);
        }
      }

      emit(VideoPickerLoaded(
        file: selectedVideo,
        thumbnailFile: thumbnailFile,
      ));
    } catch (e) {
      emit(VideoPickerFailure(errorMessage: e.toString()));
    }
  }

  void reset(int index) {
    if (index >= 0 && index < selectedVideo.length) {
      selectedVideo.removeAt(index);
      thumbnailFile.removeAt(index);
      if (selectedVideo.isEmpty && thumbnailFile.isEmpty) {
        emit(VideoPickerInitial());
      } else {
        emit(VideoPickerLoaded(
            file: selectedVideo, thumbnailFile: thumbnailFile));
      }
    }
  }

  List<String>? getSelectedVideoPath() {
    final currentState = state;
    if (currentState is VideoPickerLoaded) {
      return currentState.videoPath;
    }
    return null;
  }

  Future<File?> _generateThumbnail(File videoFile) async {
    try {
      if (![".mp4", ".mkv", ".avi", ".mov"]
          .any(videoFile.path.toLowerCase().endsWith)) {
        debugPrint("Unsupported video format: ${videoFile.path}");
        return null;
      }
      final String? thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoFile.path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 200,
        quality: 75,
      );
      if (thumbnailPath != null) {
        return File(thumbnailPath);
      }
    } catch (e) {
      debugPrint("Error generating thumbnail: $e");
    }
    return null;
  }

  List<String>? getSelectedVideoThumbnail() {
    if (state is ImageLoadedState) {
      return thumbnailFile.map((e) => e.path).toList();
    }
    return null;
  }
}
