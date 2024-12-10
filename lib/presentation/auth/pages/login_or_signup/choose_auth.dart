

part of '../auth_imports.dart';

class ChooseAuthPage extends StatelessWidget {
  const ChooseAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final isDarkTheme = AppUtils.isDarkTheme(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));
    return Scaffold(
        backgroundColor: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.chooseAuthImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 6.8 * (SizeConfigs.heightMultiplier),
                  left: 4 * (SizeConfigs.heightMultiplier),
                  right: 4 * (SizeConfigs.heightMultiplier),
                  bottom: 5.3 * (SizeConfigs.heightMultiplier)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Login Button
                  _loginButton(context),
                  SizedBox(
                    height: ComponentsSizes.defaultSpace / 2,
                  ),

                  /// Signup Button
                  _signupButton(context),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutesName.loginScreen);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                AppStrings.signin,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkFontColor),
              ),
            ),
            SizedBox(
              width: ComponentsSizes.defaultSpace / 2,
            ),
            const Icon(color: Colors.black, Icons.arrow_circle_right_rounded),
          ],
        ),
      ),
    );
  }

  Widget _signupButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkgrey,
          side: const BorderSide(color: AppColors.darkgrey),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutesName.signupScreen);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                AppStrings.register,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkFontColor),
              ),
            ),
            SizedBox(
              width: ComponentsSizes.defaultSpace / 2,
            ),
            const Icon(color: Colors.black, Icons.wifi),
          ],
        ),
      ),
    );
  }
}
