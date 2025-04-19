import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/button_bloc/button_cubit.dart';
import 'package:nepa_bid/common/bloc/button_bloc_for_auction/button_state.dart';
import 'package:nepa_bid/common/bloc/image_picker/image_picker_cubit.dart';
import 'package:nepa_bid/common/bloc/video_picker/video_picker_cubit.dart';
import 'package:nepa_bid/common/widgets/snackbar/snackbar.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/domain/auctioneer/entity/product_argument.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/text_string.dart';
import '../widgets/add_product/sized_box3.dart';
import '../widgets/add_product/sized_box4.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key, required this.productArguments});

  final TextEditingController _startingBidCon = TextEditingController();
  final ProductArguments productArguments;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ButtonCubit(),
        ),
        BlocProvider.value(
          value: MultipleImagePickerCubit(),
        ),
        BlocProvider.value(value: VideoPickerCubit())
      ],
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonLoadedA) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutesName.navPage,
              (route) => false,
            );
            CustomSnackBar.showCustomSnackBar(
              context,
              AppColors.lightPrimaryColor,
              "Successfully Created Auction",
            );
          }
          if (state is ButtonFailure) {
            debugPrint(state.errorMessage);
            CustomSnackBar.showCustomSnackBar(
              context,
              AppColors.error,
              state.errorMessage,
            );
          }
        },
        child: Scaffold(
          backgroundColor:
              isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:
                  isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
              statusBarIconBrightness:
                  isDarkTheme ? Brightness.light : Brightness.dark,
              statusBarBrightness:
                  isDarkTheme ? Brightness.dark : Brightness.light,
            ),
            title: Text(
              AppStrings.addProduct,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: ComponentsSizes.defaultSpace / 2,
                right: ComponentsSizes.defaultSpace / 2,
                top: ComponentsSizes.defaultSpace,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  /// Top SizedBox
                  TopSizedBox2(
                    isDarkTheme: isDarkTheme,
                    startingBidCon: _startingBidCon,
                  ),

                  /// Bottom SizedBox
                  BottomSizedBox2(
                    receivedStartingBid: _startingBidCon,
                    productName: productArguments.productName,
                    productCategory: productArguments.productCategory,
                    productCondition: productArguments.productCondition,
                    productDesc: productArguments.productDesc,
                    startTime: productArguments.startTime,
                    endTime: productArguments.endTime,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
