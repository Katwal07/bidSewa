// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepa_bid/common/bloc/image_picker/image_picker_cubit.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';

import '../../../../../common/bloc/image_picker/image_picker_state.dart';
import '../../../../../core/config/assets/app_vectors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/text_string.dart';

class AddProductImage extends StatelessWidget {
  const AddProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image Text
          _productImageText(context),
          SizedBox(
            height: ComponentsSizes.spaceBtwItems / 2,
          ),

          /// Product Image
          _productImage(context),
        ],
      ),
    );
  }

  Widget _productImageText(BuildContext context) {
    return Text(
      AppStrings.productImage,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _productImage(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<MultipleImagePickerCubit, MultipleImagePickerState>(
      buildWhen: (previous, current) {
        return previous.runtimeType != current.runtimeType ||
            (current is ImageLoadedState && current.file.isNotEmpty);
      },
      builder: (context, state) {
        if (state is ImageInitialState) {
          return GestureDetector(
            onTap: () => context.read<MultipleImagePickerCubit>().pickImage(),
            child: SizedBox(
              height: 60,
              child: SvgPicture.asset(
                AppVectors.image,
                height: 40,
                width: 40,
                color: isDarkTheme ? AppColors.white : AppColors.black,
              ),
            ),
          );
        }
        if (state is ImageLoadingState) {
          return const SizedBox(
            height: 60,
            child: CircularProgressIndicator(),
          );
        }
        if (state is ImageLoadedState) {
          if (state.file.isNotEmpty) {
            return SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.file.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.file(
                                    File(
                                      state.imagePath[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<MultipleImagePickerCubit>()
                                        .reset(index);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.error.withOpacity(.7),
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.close,
                                        color: AppColors.white,
                                        size: 18,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        context.read<MultipleImagePickerCubit>().pickImage(),
                    child: SvgPicture.asset(
                      AppVectors.image,
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
              onTap: () => context.read<MultipleImagePickerCubit>().pickImage(),
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
        return const SizedBox.shrink();
      },
    );
  }
}
