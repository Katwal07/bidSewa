part of 'splash_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..displaySplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticatedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
          if (state is SplashUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, AppRoutesName.onboardScreen);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.lightPrimaryColor,
          body: _splashLogo(context),
        ),
      ),
    );
  }

  Widget _splashLogo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.appLogo),
        SizedBox(height: ComponentsSizes.defaultSpace*5,),
        const CircularProgressIndicator(color: Colors.white,)
      ],
    );
  }
}
