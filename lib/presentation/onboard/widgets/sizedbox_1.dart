part of '../page/onboard_imports.dart';

class TopFractionalSizedBox extends StatelessWidget {
  const TopFractionalSizedBox({
    super.key, required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.7,
      child: PageView(
        controller: pageController,
        pageSnapping: true,
        onPageChanged: (index){
          context.read<OnboardCubit>().updatePage(index);
        },
        scrollDirection: Axis.horizontal,
        children: [
          _firstPageView(),
          _secondPageView(),
          _thirdPageView(),
        ],
      ),
    );
  }

  Widget _firstPageView() {
    return const HorizontalPageView(
      image: AppImages.onboard1,
      titleDesc: AppStrings.onboardTitle1,
      subTitleDesc: AppStrings.onboardSubTitle1,
    );
  }

  Widget _secondPageView() {
    return const HorizontalPageView(
      image: AppImages.onboard2,
      titleDesc: AppStrings.onboardTitle2,
      subTitleDesc: AppStrings.onboardSubTitle1,
    );
  }

  Widget _thirdPageView() {
    return const HorizontalPageView(
      image: AppImages.onboard3,
      titleDesc: AppStrings.onboardTitle3,
      subTitleDesc: AppStrings.onboardSubTitle3,
    );
  }
}
