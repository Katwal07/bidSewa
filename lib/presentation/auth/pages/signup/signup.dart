part of '../auth_imports.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = AppUtils.isDarkTheme(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckBoxCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ImagePickerCubit(),
        ),
         BlocProvider(
          create: (context) => PasswordVisiblityCubit(),
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ButtonLoadingState) {
            const CircularProgressIndicator();
          }
          if (state is ButtonLoadedState) {
            CustomSnackBar.showCustomSnackBar(
              context,
              AppColors.borderPrimary,
              state.message,
            );
          }
          if (state is ButtonFailureState) {
             CustomSnackBar.showCustomSnackBar(
              context,
              AppColors.error,
              state.errorMessage,
            );
            context.read<AuthCubit>().reset();
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          backgroundColor: AppColors.lightPrimaryColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ComponentsSizes.defaultSpace,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Singup Text
                    _signupText(context),
                    
                    SizedBox(
                      height: ComponentsSizes.defaultSpace * 3,
                    ),

                    /// Signup Form
                    SignupForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signupText(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            AppStrings.singup,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            AppStrings.joinTheJourney,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
