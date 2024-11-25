part of 'onboard_imports.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({super.key});

  final OnBoardPageController onBoardPageController = OnBoardPageController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => OnboardCubit(),
      child: Scaffold(
        backgroundColor: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding),
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// Top Fractional SizedBox
              TopFractionalSizedBox(pageController: onBoardPageController.pageController,),

              /// Bottom Fractional SizedBox
              BottomFractionalSizedBox(pageController: onBoardPageController.pageController,),
            ],
          ),
        )),
      ),
    );
  }
}
