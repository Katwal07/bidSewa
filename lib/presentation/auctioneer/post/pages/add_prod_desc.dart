import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nepa_bid/common/bloc/image_picker/image_picker_cubit.dart';
import 'package:nepa_bid/common/bloc/video_picker/video_picker_cubit.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/core/constant/text_string.dart';
import 'package:nepa_bid/domain/auctioneer/entity/product_argument.dart';
import 'package:nepa_bid/presentation/auctioneer/post/bloc/date_time_picker_cubit.dart';

import '../widgets/add_product_details/sized_box1.dart';
import '../widgets/add_product_details/sized_box2.dart';

class AddProductDetails extends StatelessWidget {
  AddProductDetails({super.key});

  final TextEditingController _productNameCon = TextEditingController();
  final TextEditingController _productConditionCon = TextEditingController();
  final TextEditingController _productCategoryCon = TextEditingController();
  final TextEditingController _productDescCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MultipleImagePickerCubit(),
        ),
        BlocProvider(
          create: (context) => VideoPickerCubit(),
        ),BlocProvider(create: (context)=> DateTimePickerCubit())
      ],
      child: Scaffold(
        backgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        appBar: AppBar(
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
                TopSizedBox1(
                  isDarkTheme: isDarkTheme,
                  productNameCon: _productNameCon,
                  productCategoryCon: _productCategoryCon,
                  productConditionCon: _productConditionCon,
                  productDescCon: _productDescCon,
                ),

                /// Bottom SizedBox
                Builder(
                  builder: (context) {
                    return BottomSizedBox1(
                      onContinue: () {
                        DateTime now = DateTime.now();
                         final DateTimePickerCubit dateTimePickerCubit =
                          context.read<DateTimePickerCubit>();
                          final DateTime? getEndTime =
                          dateTimePickerCubit.getUserCombinedDateTime();
                        final productName = _productNameCon.text;
                        final productCategory = _productCategoryCon.text;
                        final productCondition = _productConditionCon.text;
                        final productDesc = _productDescCon.text;
                    
                        Navigator.pushNamed(
                          context,
                          AppRoutesName.addPostAuctionner,
                          arguments: ProductArguments(
                            productName: productName,
                            productCategory: productCategory,
                            productCondition: productCondition,
                            productDesc: productDesc,
                            startTime: DateFormat('yyyy-MM-dd HH:mm').format(now).toString(),
                            endTime: getEndTime.toString(),
                          ),
                        );
                      },
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
