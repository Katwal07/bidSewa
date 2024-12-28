part of 'onboard_imports.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({super.key});

  final OnBoardPageController onBoardPageController = OnBoardPageController();

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return BlocProvider(
      create: (context) => OnboardCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          darkStatusBarColor: AppColors.darkBgColor,
          lightStatusBarColor: AppColors.lightBgColor,
          kCustomToolBarheight: 0,
        ),
        backgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding),
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// Top Fractional SizedBox
              TopFractionalSizedBox(
                pageController: onBoardPageController.pageController,
              ),

              /// Bottom Fractional SizedBox
              BottomFractionalSizedBox(
                pageController: onBoardPageController.pageController,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
