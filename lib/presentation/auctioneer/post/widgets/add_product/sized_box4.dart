import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/button_bloc/button_cubit.dart';
import 'package:nepa_bid/common/bloc/image_picker/image_picker_cubit.dart';
import 'package:nepa_bid/common/bloc/video_picker/video_picker_cubit.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/common/widgets/button/others_reactive_button.dart';
import 'package:nepa_bid/common/widgets/snackbar/snackbar.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/create_auction_usecase.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../../domain/auctioneer/entity/post_auction.dart';

class BottomSizedBox2 extends StatelessWidget {
  const BottomSizedBox2({
    super.key,
    required this.receivedStartingBid,
    required this.productName,
    required this.productCategory,
    required this.productCondition,
    required this.productDesc,
    required this.startTime,
    required this.endTime,
  });

  final TextEditingController receivedStartingBid;
  final String productName;
  final String productCategory;
  final String productCondition;
  final String productDesc;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ButtonCubit, ButtonState>(
      listener: (context, state) {
        if(state is ButtonLoaded){
          Navigator.pushNamedAndRemoveUntil(context, AppRoutesName.navPage, (route)=> false);
        }
      },
      child: FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.12,
        child: Padding(
          padding: EdgeInsets.only(bottom: 3.52 * SizeConfigs.heightMultiplier),
          child: SizedBox(
            width: double.infinity,
            child: Builder(builder: (context) {
              return OthersReactiveButton(
                onPressed: () async {
                  final MultipleImagePickerCubit imagePickerCubit =
                      context.read<MultipleImagePickerCubit>();
                  final VideoPickerCubit videoPickerCubit =
                      context.read<VideoPickerCubit>();
                  final List<String>? imagesPath =
                      imagePickerCubit.getSelectedImagePath();
                  final List<String> videosPath =
                      videoPickerCubit.getSelectedVideoPath() ?? [];

                  if (imagesPath == null || imagesPath.isEmpty) {
                    CustomSnackBar.showCustomSnackBar(
                      context,
                      AppColors.warning,
                      "Please select at least one image",
                    );
                    return;
                  }
                  debugPrint(productName);
                  debugPrint(productCategory);
                  debugPrint(productCondition);
                  debugPrint(productDesc);
                  debugPrint(receivedStartingBid.text);
                  debugPrint(startTime);
                  debugPrint(endTime);

                  context.read<ButtonCubit>().execute(
                        usecase: sl<CreateAuctionUsecase>(),
                        params: PostAuctionItemEntity(
                          title: productName,
                          description: productDesc,
                          category: productCategory,
                          condition: productCondition,
                          startingBid: int.tryParse(receivedStartingBid.text),
                          startTime: startTime,
                          endTime: endTime,
                          images: imagesPath.map((e) => File(e)).toList(),
                          videos: videosPath.map((e) => File(e)).toList(),
                        ),
                        context: context,
                      );
                },
                label: "Publish Product",
              );
            }),
          ),
        ),
      ),
    );
  }
}
