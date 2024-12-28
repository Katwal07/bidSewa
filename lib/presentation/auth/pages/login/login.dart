part of '../auth_imports.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final TextEditingController _emailCon = TextEditingController();

  final TextEditingController _passCon = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NetworkCubit(
            networkInfoRepository: sl<NetworkInfoRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
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
                ),
                backgroundColor: AppColors.lightPrimaryColor,
                body: SafeArea(
                    child: Padding(
                  padding: _padding(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// SignIn Text
                        _signinText(context),

                        /// Default Space
                        _largeDefaultSpace(),

                        /// Login Form
                        _loginForm(
                          context,
                        ),
                      ],
                    ),
                  ),
                )),
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
        color: isDarkTheme ? AppColors.darkContainerColor : AppColors.lightContainerColor,
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

                /// Sign In Button
                _signInButton(),

                _spaceBtwField(),

                /// Don't Have an Account
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
      style: Theme.of(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: AppColors.white),
    );
  }

  Widget _signInDesc(BuildContext context) {
    return Text(
      AppStrings.unlockYourWorld,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: AppColors.white),
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
      validator: AppValidator.checkEmail,
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
            validator: AppValidator.checkPassword,
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
            validator: AppValidator.checkPassword,
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
                context.read<AuthCubit>().execute(
                      usecase: sl<SignInUseCase>(),
                      params: SigninReqParamsEntity(
                        email: _emailCon.text,
                        password: _passCon.text,
                      ),
                      context: context,
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
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutesName.signupScreen),
          child: Text(
            AppStrings.createAccount,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.lightPrimaryColor,
                ),
          ),
        ),
      ],
    );
  }
}
