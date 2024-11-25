part of '../page/onboard_imports.dart';

class BottomFractionalSizedBox extends StatelessWidget {
  const BottomFractionalSizedBox({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.bottomCenter,
      heightFactor: 0.3,
      child: Column(
        children: [
          SizedBox(
            height: ComponentsSizes.defaultSpace * 4,
          ),

          /// Get Started Button
          _onboardButton(context),
          SizedBox(
            height: ComponentsSizes.defaultSpace,
          ),

          /// Skip , page indicator and Next Button
          _skpAndNextButton(context),
        ],
      ),
    );
  }

  Widget _onboardButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutesName.authScreen);
        },
        child: const Text(AppStrings.getStarted),
      ),
    );
  }

  Widget _skpAndNextButton(BuildContext context) {
    return BlocBuilder<OnboardCubit, OnboardState>(
      builder: (context, state) {
        if (state is OnBoardPageChanged) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Skip Button
              TextButton(
                onPressed: () {
                  pageController.jumpToPage(2);
                },
                child: Text(
                  AppStrings.skip,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.lightPrimaryColor),
                ),
              ),

              /// Page Indicator
              Row(
                children: List.generate(
                  3,
                  (index) {
                    return Container(
                      width: 5 * SizeConfigs.widthMultiplier,
                      height: 1.07 * SizeConfigs.heightMultiplier,
                      decoration: BoxDecoration(
                        shape: state.pageIndex == index
                            ? BoxShape.rectangle
                            : BoxShape.circle,
                        borderRadius: state.pageIndex == index
                            ? BorderRadius.circular(
                                ComponentsSizes.borderRadiusLg)
                            : null,
                        color: state.pageIndex == index
                            ? AppColors.buttonPrimary
                            : AppColors.grey,
                      ),
                    );
                  },
                ),
              ),

              /// Next Button
              TextButton(
                onPressed: () {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: Text(
                  AppStrings.next,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.lightPrimaryColor),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
