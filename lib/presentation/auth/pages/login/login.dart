part of '../auth_imports.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passCon = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonCubit(),
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonLoading) {
            const CircularProgressIndicator();
          }
          if (state is ButtonLoaded) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
          if (state is ButtonFailure) {
            var snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          backgroundColor:
              AppColors.lightPrimaryColor,
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding,
              vertical: ComponentsSizes.defaultSpace,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// SignIn text
                  _signinText(context),
                  SizedBox(
                    height: ComponentsSizes.defaultSpace * 5,
                  ),

                  /// Login Form
                  _loginForm(context,),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  _signinText(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            AppStrings.signin,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            AppStrings.unlockYourWorld,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  _loginForm(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 46 * (SizeConfigs.heightMultiplier),
      decoration: BoxDecoration(
        color: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        border: Border.all(color: AppColors.darkgrey),
        borderRadius: BorderRadius.circular(
          ComponentsSizes.borderRadiusLg,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(ComponentsSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            /// Email Id Text
            Text(
              AppStrings.emailId,
              style: Theme.of(context).textTheme.titleMedium
            ),
            SizedBox(
              height: ComponentsSizes.spaceBtwInputFields,
            ),
            
            /// Email Id TextField
            TextFormField(
              controller: _emailCon,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: AppStrings.enterEmail,
                prefixIcon: Icon(size: ComponentsSizes.iconMd, Icons.mail),
              ),
            ),
            SizedBox(
              height: ComponentsSizes.spaceBtwInputFields,
            ),

            /// Password Text
            Text(
              AppStrings.password,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: ComponentsSizes.spaceBtwInputFields,
            ),

            /// Password TextField
            TextFormField(
              controller: _passCon,
              obscureText: true,
              obscuringCharacter: AppStrings.obscuredCharacter,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  size: ComponentsSizes.iconMd,
                  Icons.lock,
                ),
                suffixIcon: Icon(
                  size: ComponentsSizes.iconMd,
                  Icons.remove_red_eye,
                ),
                hintText: AppStrings.enterPass,
              ),
            ),
            SizedBox(
              height: ComponentsSizes.spaceBtwSection,
            ),

            /// Signin Button
            Builder(
              builder: (context) {
                return SizedBox(
                  width: double.infinity,
                  child: AppReactiveButton(
                    label: AppStrings.signin, 
                    onPressed: () { 
                      context.read<ButtonCubit>().execute(
                        usecase: sl<SignInUseCase>(),
                        params: SigninReqParams(
                          email: _emailCon.text, 
                          password: _passCon.text
                        ),
                      );
                     },
                  ),
                );
              },
            ),
            const SizedBox(
              height: ComponentsSizes.md,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: FittedBox(
                    child: Text(
                      AppStrings.dontHaveAnAccount,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutesName.signupScreen),
                  child: Text(
                    AppStrings.createAccount,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.lightPrimaryColor,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
