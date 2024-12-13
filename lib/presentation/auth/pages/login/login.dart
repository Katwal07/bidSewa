part of '../auth_imports.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passCon = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkTheme
          ? AppColors.lightPrimaryColor
          : AppColors.lightPrimaryColor,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ButtonCubit(),
        ),
        BlocProvider(
          create: (context) => PasswordVisiblityCubit(),
        ),
      ],
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonLoading) {
            const CircularProgressIndicator();
          }
          if (state is ButtonLoaded) {
            if (state.success) {
              if (state.role == "Auctioneer") {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutesName.navPage, (route) => false);
                CustomSnackBar.showCustomSnackBar(
                  context,
                  AppColors.borderPrimary,
                  state.message,
                );
              } else if (state.role == "Bidder") {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutesName.navPageBidder, (route) => false);
              } else {
                debugPrint("Navigation not triggered; role is //${state.role}");
              }
            } else {
              CustomSnackBar.showCustomSnackBar(
                context,
                Colors.redAccent,
                state.message,
              );
              debugPrint(state.message);
            }
          }
          if (state is ButtonFailure) {
            showDialog(
              context: context, 
              builder: (context)=> AppErrorWidget(
                errorType: state.errorType, 
                buttonCubit: context.read<ButtonCubit>()
              ),
            );
            // CustomSnackBar.showCustomSnackBar(
            //   context,
            //   Colors.redAccent,
            //   state.message,
            // );
            // debugPrint(state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          backgroundColor: AppColors.lightPrimaryColor,
          body: SafeArea(
              child: Padding(
            padding: _padding(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// SignIn text
                  _signinText(context),

                  _largeDefaultSpace(),

                  /// Login Form
                  _loginForm(
                    context,
                  ),
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
          _signInTitle(context),
          _signInDesc(context),
        ],
      ),
    );
  }

  _loginForm(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return Container(
      height: 42 * (SizeConfigs.heightMultiplier),
      decoration: BoxDecoration(
        color: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        border: Border.all(color: AppColors.darkgrey),
        borderRadius: BorderRadius.circular(
          ComponentsSizes.borderRadiusLg,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ComponentsSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Email Id Text

                _emailIdText(context),

                _spaceBtwField(),

                /// Email Id TextField
                _emailTextField(),

                _spaceBtwField(),

                /// Password Text

                _passText(context),

                _spaceBtwField(),

                /// Password TextField
                _passTextField(),

                _spaceBtwSection(),

                /// Signin Button
                _signInButton(),

                _spaceBtwField(),

                _dontHaveAnAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _spaceBtwField() {
    return SizedBox(
      height: ComponentsSizes.spaceBtwInputFields,
    );
  }

  Widget _spaceBtwSection() {
    return SizedBox(
      height: ComponentsSizes.spaceBtwSection,
    );
  }

  EdgeInsetsGeometry _padding() {
    return EdgeInsets.symmetric(
      horizontal: ComponentsSizes.horizontalPadding,
      vertical: ComponentsSizes.defaultSpace,
    );
  }

  Widget _largeDefaultSpace() {
    return SizedBox(
      height: ComponentsSizes.defaultSpace * 5,
    );
  }

  Widget _signInTitle(BuildContext context) {
    return Text(
      AppStrings.signin,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget _signInDesc(BuildContext context) {
    return Text(
      AppStrings.unlockYourWorld,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _emailIdText(BuildContext context) {
    return Text(
      AppStrings.emailId,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: _emailCon,
      validator: AppValidator.validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: AppStrings.enterEmail,
        prefixIcon: Icon(size: ComponentsSizes.iconMd, Icons.mail),
      ),
    );
  }

  Widget _passText(BuildContext context) {
    return Text(
      AppStrings.password,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _passTextField() {
    return BlocBuilder<PasswordVisiblityCubit, PasswordVisibilityState>(
      builder: (context, state) {
        if (state is PasswordVisibilityInitial) {
          return TextFormField(
            controller: _passCon,
            validator: AppValidator.validatePassword,
            obscureText: state.obscureText,
            obscuringCharacter: AppStrings.obscuredCharacter,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: Icon(
                size: ComponentsSizes.iconMd,
                Icons.lock,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  context
                      .read<PasswordVisiblityCubit>()
                      .onClick(state.obscureText);
                },
                icon: Icon(
                  Icons.visibility,
                  size: ComponentsSizes.iconMd,
                ),
              ),
              hintText: AppStrings.enterPass,
            ),
          );
        }
        if (state is PasswordVisibilityLoaded) {
          return TextFormField(
            controller: _passCon,
            validator: AppValidator.validatePassword,
            obscureText: state.obscureText,
            obscuringCharacter: AppStrings.obscuredCharacter,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: Icon(
                size: ComponentsSizes.iconMd,
                Icons.lock,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  context
                      .read<PasswordVisiblityCubit>()
                      .onClick(state.obscureText);
                },
                icon: state.obscureText == true
                    ? Icon(
                        Icons.visibility,
                        size: ComponentsSizes.iconMd,
                      )
                    : Icon(
                        Icons.visibility_off,
                        size: ComponentsSizes.iconMd,
                      ),
              ),
              hintText: AppStrings.enterPass,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _signInButton() {
    return Builder(
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: AppReactiveButton(
            label: AppStrings.signin,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<ButtonCubit>().execute(
                      usecase: sl<SignInUseCase>(),
                      params: SigninReqParams(
                        email: _emailCon.text,
                        password: _passCon.text,
                      ),
                    );
              }
            },
          ),
        );
      },
    );
  }

  Widget _dontHaveAnAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAnAccount,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutesName.signupScreen),
          child: Text(
            AppStrings.createAccount,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.lightPrimaryColor,
                ),
          ),
        ),
      ],
    );
  }
}
