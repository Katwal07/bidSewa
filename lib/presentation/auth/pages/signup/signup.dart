part of '../auth_imports.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NetworkCubit(networkInfoRepository: sl<NetworkInfoRepository>()),
        ),
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
        child: BlocBuilder<NetworkCubit, ConnectivityState>(
          builder: (context, state) {
            if (state is NetworkConnected) {
              return Scaffold(
                appBar: CustomAppBar(
                  darkStatusBarColor: AppColors.lightPrimaryColor,
                  lightStatusBarColor: AppColors.lightPrimaryColor,
                  statusBarBrightness: Brightness.dark,
                  icon: Navigator.canPop(context) ? Icons.arrow_back : null,
                ),
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
                          const SignupForm(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            if (state is NetworkDisconnected) {
              return const NoInternetConnectionWidget();
            }
            if (state is NetworkChecking) {
              return const NoInternetConnectionWidget();
            }
            return const SizedBox.shrink();
          },
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
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.darkFontColor),
          ),
          Text(
            AppStrings.joinTheJourney,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.darkFontColor),
          ),
        ],
      ),
    );
  }
}
