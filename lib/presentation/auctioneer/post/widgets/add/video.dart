
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../common/bloc/video_picker/video_picker_cubit.dart';
import '../../../../../common/bloc/video_picker/video_picker_state.dart';
import '../../../../../core/config/assets/app_vectors.dart';
import '../../../../../core/config/theme/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/text_string.dart';

class AddProductVideo extends StatelessWidget {
  const AddProductVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Add Video Text
          _addVideoText(context),
          SizedBox(
            height: ComponentsSizes.spaceBtwItems / 2,
          ),

          /// Product Video
          _productVideo(context),
        ],
      ),
    );
  }

  Widget _addVideoText(BuildContext context) {
    return Text(
      AppStrings.addVideo,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _productVideo(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<VideoPickerCubit, VideoPickerState>(
      builder: (context, state) {
        if (state is VideoPickerInitial) {
          return GestureDetector(
            onTap: () => context.read<VideoPickerCubit>().pickVideo(),
            child: SizedBox(
              height: 60,
              child: SvgPicture.asset(
                AppVectors.video,
                height: 40,
                width: 40,
                color: isDarkTheme ? AppColors.white : AppColors.black,
              ),
            ),
          );
        }
        if (state is VideoPickerLoading) {
          return const SizedBox(
            height: 60,
            child: CircularProgressIndicator(),
          );
        }
        if (state is VideoPickerLoaded) {
          if (state.thumbnailFile.isNotEmpty) {
            return SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.thumbnailFile.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Image.file(
                                          state.thumbnailFile[index],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        right: 50,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.videocam,
                                            color: AppColors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<VideoPickerCubit>()
                                        .reset(index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.error.withOpacity(.7),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.close,
                                      color: AppColors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.read<VideoPickerCubit>().pickVideo(),
                    child: SvgPicture.asset(
                      AppVectors.video,
                      height: 40,
                      width: 40,
                      color: isDarkTheme ? AppColors.white : AppColors.black,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () => context.read<VideoPickerCubit>().pickVideo(),
              child: SizedBox(
                height: 60,
                child: SvgPicture.asset(
                  AppVectors.image,
                  height: 40,
                  width: 40,
                ),
              ),
            );
          }
        }
        return GestureDetector(
          onTap: () => context.read<VideoPickerCubit>().pickVideo(),
          child: SizedBox(
            height: 60,
            child: SvgPicture.asset(
              AppVectors.video,
              height: 40,
              width: 40,
            ),
          ),
        );
      },
    );
  }
}
