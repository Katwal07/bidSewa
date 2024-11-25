part of '../auth_imports.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => ButtonCubit(),
        ),
         BlocProvider(
          create: (context) => ImagePickerCubit(),
        ),
      ],
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonLoading) {
            const CircularProgressIndicator();
          }
          if (state is ButtonLoaded) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
          if (state is ButtonFailure) {
            var snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    const SignupForm(),
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
