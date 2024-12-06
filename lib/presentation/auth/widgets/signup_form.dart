part of '../pages/auth_imports.dart';

class SignupForm extends StatelessWidget {
  SignupForm({super.key});

  final TextEditingController _fullNameCon = TextEditingController();

  final TextEditingController _emailCon = TextEditingController();

  final TextEditingController _passwordCon = TextEditingController();

  final TextEditingController _phoneNumberCon = TextEditingController();

  final TextEditingController _bankAccountNameCon = TextEditingController();

  final TextEditingController _bankAccountNumberCon = TextEditingController();

  final TextEditingController _bankNameCon = TextEditingController();

  final TextEditingController _swiftCodeCon = TextEditingController();

  final TextEditingController _addressCon = TextEditingController();

  final TextEditingController _payPalEmailCon = TextEditingController();

  final TextEditingController _imePayNoCon = TextEditingController();

  final TextEditingController _khaltiCon = TextEditingController();

  final TextEditingController _esewaCon = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = AppUtils.isDarkTheme(context);
    return BlocBuilder<CheckBoxCubit, CheckBoxState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            height: ComponentsSizes.productItemHeight * 2,
            decoration: BoxDecoration(
              color:
                  isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
              borderRadius: BorderRadius.all(
                Radius.circular(ComponentsSizes.borderRadiusLg),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                ComponentsSizes.defaultSpace,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Bidder
                      if (state.checkbox1) ...[
                        Column(
                          children: [
                            /// Submit Your Details
                            _submitYourDetailsText(context),

                            SizedBox(
                              height: ComponentsSizes.spaceBtwInputFields * 2,
                            ),

                            /// FullName TextField
                            _fullNameTextField(),

                            _spaceBtwInputFields(),

                            /// Email TextField
                            _emailTextField(),

                            _spaceBtwInputFields(),

                            /// Password TextField
                            _passwordTextField(),

                            _spaceBtwInputFields(),

                            /// PhoneNumber TextField
                            _phoneNumberTextField(),

                            _spaceBtwInputFields(),

                            /// Upload ProfileImage
                            _uploadProfileImage(context),

                            /// Select Role
                            _selectRole(context),

                            _spaceBtwInputFields(),

                            /// Signup Button
                            _signupButton(context),


                            /// Don't Have an Account
                            _dontHaveAccountText(context),
                          ],
                        ),
                      ],

                      //! Auctioneer
                      if (state.checkbox2) ...[
                        Column(
                          children: [
                            /// Submit Your Details
                            _submitYourDetailsText(context),

                            SizedBox(
                              height: ComponentsSizes.spaceBtwInputFields * 2,
                            ),

                            /// FullName TextField
                            _fullNameTextField(),

                            _spaceBtwInputFields(),

                            /// Email TextField
                            _emailTextField(),

                            _spaceBtwInputFields(),

                            /// Password TextField
                            _passwordTextField(),

                            _spaceBtwInputFields(),

                            /// PhoneNumber TextField
                            _phoneNumberTextField(),

                            _spaceBtwInputFields(),

                            /// BankAccount Holder TextField
                            _bankAccountHolderNameTextField(),

                            _spaceBtwInputFields(),

                            /// BankAccount Number TextField
                            _bankAccountNumberTextField(),

                            _spaceBtwInputFields(),

                            /// Bank Name TextField
                            _bankNameTextField(),

                            _spaceBtwInputFields(),

                            /// Bank IdentifierCode TextField
                            _bankIdentifierCodeTextField(),

                            _spaceBtwInputFields(),

                            /// UserAddress TextField
                            _userAddressTextField(),

                            _spaceBtwInputFields(),

                            /// PayPal Email TextField
                            _payPalEmailTextField(),

                            _spaceBtwInputFields(),

                            /// ImePay Number TextField
                            _imePayNumberTextField(),

                            _spaceBtwInputFields(),

                            /// Khalti Number TextField
                            _khaltiNumberTextField(),

                            _spaceBtwInputFields(),

                            /// Esewa Number TextField
                            _eSewaNumberTextField(),

                            _spaceBtwInputFields(),

                            /// Upload Profile Image
                            _uploadProfileImage(context),

                            /// SelectRole
                            _selectRole(context),

                            _spaceBtwInputFields(),

                            /// Signup Button
                            _signupButtonForAuctioneer(context),


                            /// Don't Have an Account
                            _dontHaveAccountText(context),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _submitYourDetailsText(BuildContext context) {
    return Text(
      AppStrings.submitYourDetails,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _fullNameTextField() {
    return TextFormField(
      controller: _fullNameCon,
      keyboardType: TextInputType.text,
      validator: AppValidator.validateName,
      decoration: const InputDecoration(
        labelText: AppStrings.enterFullName,
        prefixIcon: Icon(CupertinoIcons.person),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: _emailCon,
      keyboardType: TextInputType.emailAddress,
      validator: AppValidator.validateEmail,
      decoration: const InputDecoration(
        labelText: AppStrings.enterEmail,
        prefixIcon: Icon(CupertinoIcons.mail),
      ),
    );
  }

  Widget _passwordTextField() {
    return BlocBuilder<PasswordVisiblityCubit, PasswordVisibilityState>(
      builder: (context, state) {
        if (state is PasswordVisibilityInitial) {
          return TextFormField(
            controller: _passwordCon,
            validator: AppValidator.validatePassword,
            obscureText: state.obscureText,
            obscuringCharacter: AppStrings.obscuredCharacter,
            decoration: InputDecoration(
              prefixIcon: Icon(
                size: ComponentsSizes.iconMd,
                Icons.lock_outline,
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
            controller: _passwordCon,
            validator: AppValidator.validatePassword,
            obscureText: state.obscureText,
            obscuringCharacter: AppStrings.obscuredCharacter,
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

  Widget _phoneNumberTextField() {
    return TextFormField(
      controller: _phoneNumberCon,
      keyboardType: TextInputType.phone,
      validator: AppValidator.validatePhoneNumber,
      decoration: const InputDecoration(
        labelText: AppStrings.phoneNumber,
        prefixIcon: Icon(CupertinoIcons.phone),
      ),
    );
  }

  Widget _uploadProfileImage(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        if (state is ImageInitialState) {
          return Row(
            children: [
              Container(
                height: SizeConfigs.heightMultiplier * 4.3,
                width: SizeConfigs.widthMultiplier * 9.3,
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? AppColors.darkBgColor
                      : AppColors.lightBgColor,
                  border: Border.all(
                      color: isDarkTheme ? AppColors.grey : AppColors.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ComponentsSizes.buttonRadius),
                    bottomLeft: Radius.circular(ComponentsSizes.buttonRadius),
                  ),
                ),
                child: IconButton(
                    onPressed: () {
                      context.read<ImagePickerCubit>().pickImage();
                    },
                    icon: const Icon(Icons.image_outlined)),
              ),
              Container(
                height: SizeConfigs.heightMultiplier * 4.3,
                width: SizeConfigs.widthMultiplier * 30,
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? AppColors.darkBgColor
                      : AppColors.lightBgColor,
                  border: Border.all(
                      color: isDarkTheme ? AppColors.grey : AppColors.black),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ComponentsSizes.buttonRadius),
                    bottomRight: Radius.circular(ComponentsSizes.buttonRadius),
                  ),
                ),
                child: const Center(
                  child: Text(AppStrings.selectImage),
                ),
              ),
            ],
          );
        }

        if (state is ImageLoadedState) {
          return Row(
            children: [
              Container(
                height: SizeConfigs.heightMultiplier * 6.3,
                width: SizeConfigs.widthMultiplier * 13,
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? AppColors.darkBgColor
                      : AppColors.lightBgColor,
                  border: Border.all(
                      color: isDarkTheme ? AppColors.grey : AppColors.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ComponentsSizes.buttonRadius),
                    bottomLeft: Radius.circular(ComponentsSizes.buttonRadius),
                  ),
                ),
                child: GestureDetector(
                  onTap: () async {
                    context.read<ImagePickerCubit>().pickImage();
                    await Future.delayed(const Duration(seconds: 1));

                    /// Checks if widget is still part of the tree
                    if (!context.mounted) return;
                    context.read<ImagePickerCubit>().reset();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ComponentsSizes.buttonRadius),
                      bottomLeft: Radius.circular(ComponentsSizes.buttonRadius),
                    ),
                    child: Image.file(
                      File(state.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                height: SizeConfigs.heightMultiplier * 6.3,
                width: SizeConfigs.widthMultiplier * 30,
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? AppColors.darkBgColor
                      : AppColors.lightBgColor,
                  border: Border.all(
                      color: isDarkTheme ? AppColors.grey : AppColors.black),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ComponentsSizes.buttonRadius),
                    bottomRight: Radius.circular(ComponentsSizes.buttonRadius),
                  ),
                ),
                child: Center(
                  child: Text(state.displayName),
                ),
              ),
            ],
          );
        }
        return Row(
          children: [
            Container(
              height: SizeConfigs.heightMultiplier * 4.3,
              width: SizeConfigs.widthMultiplier * 9.3,
              decoration: BoxDecoration(
                color: isDarkTheme
                    ? AppColors.darkBgColor
                    : AppColors.lightBgColor,
                border: Border.all(
                    color: isDarkTheme ? AppColors.grey : AppColors.black),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ComponentsSizes.buttonRadius),
                  bottomLeft: Radius.circular(ComponentsSizes.buttonRadius),
                ),
              ),
              child: IconButton(
                  onPressed: () {
                    context.read<ImagePickerCubit>().pickImage();
                  },
                  icon: const Icon(Icons.image_outlined)),
            ),
            Container(
              height: SizeConfigs.heightMultiplier * 4.3,
              width: SizeConfigs.widthMultiplier * 30,
              decoration: BoxDecoration(
                color: isDarkTheme
                    ? AppColors.darkBgColor
                    : AppColors.lightBgColor,
                border: Border.all(
                    color: isDarkTheme ? AppColors.grey : AppColors.black),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(ComponentsSizes.buttonRadius),
                  bottomRight: Radius.circular(ComponentsSizes.buttonRadius),
                ),
              ),
              child: const Center(
                child: Text(AppStrings.selectImage),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _selectRole(BuildContext context) {
    return BlocBuilder<CheckBoxCubit, CheckBoxState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.checkbox1,
              onChanged: (value) {
                if (value != null) {
                  context.read<CheckBoxCubit>().toggleCheckbox1();
                }
              },
            ),
            Text(
              AppStrings.bidder,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              width: ComponentsSizes.defaultSpace,
            ),
            Checkbox(
              value: state.checkbox2,
              onChanged: (value) {
                if (value != null) {
                  context.read<CheckBoxCubit>().toggleCheckbox2();
                }
              },
            ),
            Text(
              AppStrings.auctioneer,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        );
      },
    );
  }

  Widget _signupButton(BuildContext context) {
    final ImagePickerCubit imagePickerCubit = context.read<ImagePickerCubit>();

    return Builder(builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: AppReactiveButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final String? profileImagePath =
                    imagePickerCubit.getSelectedImagePath();

                if (profileImagePath == null || profileImagePath.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(AppStrings.pleaseSelectProfileImage)),
                  );
                  return;
                }

                final File profileImage = File(profileImagePath);

                context.read<ButtonCubit>().execute(
                      usecase: sl<SignUpUseCase>(),
                      params: SignupReqParams(
                        fullName: _fullNameCon.text,
                        phoneNumber: _phoneNumberCon.text,
                        email: _emailCon.text,
                        password: _passwordCon.text,
                        profileImage: profileImage,
                      ),
                    );
              }
            },
            label: AppStrings.singup),
      );
    });
  }

  Widget _signupButtonForAuctioneer(BuildContext context) {
    ImagePickerCubit imagePickerCubit = context.read<ImagePickerCubit>();

    return Builder(builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: AppReactiveButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final String? profileImagePath =
                  imagePickerCubit.getSelectedImagePath();

              if (profileImagePath == null || profileImagePath.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(AppStrings.pleaseSelectProfileImage)),
                );
                return;
              }

              final File profileImage = File(profileImagePath);

              context.read<ButtonCubit>().execute(
                    usecase: sl<SignupUseCaseForAuctioneer>(),
                    params: SignupReqParamsForAuctioneer(
                      fullName: _fullNameCon.text,
                      email: _emailCon.text,
                      password: _passwordCon.text,
                      phoneNumber: _phoneNumberCon.text,
                      profileImage: profileImage,
                      bankAccountName: _bankAccountNameCon.text,
                      bankAccountNumber: _bankAccountNumberCon.text,
                      bankName: _bankNameCon.text,
                      swiftCode: _swiftCodeCon.text,
                      address: _addressCon.text,
                      paypalEmail: _payPalEmailCon.text,
                      imepayNumber: _imePayNoCon.text,
                      khaltiNumber: _khaltiCon.text,
                      esewaNumber: _esewaCon.text,
                    ),
                  );
            }
          },
          label: AppStrings.singup,
        ),
      );
    });
  }

  Widget _dontHaveAccountText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.haveAnAccout,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutesName.loginScreen);
          },
          child: Text(
            AppStrings.signin,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors.lightPrimaryColor),
          ),
        )
      ],
    );
  }

  Widget _bankAccountHolderNameTextField() {
    return TextFormField(
      controller: _bankAccountNameCon,
      validator: AppValidator.validateAccountHolderName,
      decoration: const InputDecoration(
          labelText: AppStrings.bankAccountHolderName,
          prefixIcon: Icon(CupertinoIcons.person)),
    );
  }

  Widget _bankAccountNumberTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: AppValidator.validateBankAccountNumber,
      controller: _bankAccountNumberCon,
      decoration: const InputDecoration(
          labelText: AppStrings.bankAccountNumber,
          prefixIcon: Icon(Icons.account_box)),
    );
  }

  Widget _bankNameTextField() {
    return TextFormField(
      validator: AppValidator.validateBankName,
      keyboardType: TextInputType.text,
      controller: _bankNameCon,
      decoration: const InputDecoration(
          labelText: AppStrings.bankName,
          prefixIcon: Icon(Icons.account_balance)),
    );
  }

  Widget _bankIdentifierCodeTextField() {
    return TextFormField(
      controller: _swiftCodeCon,
      keyboardType: TextInputType.text,
      validator: AppValidator.validateBankIdentifierCode,
      decoration: const InputDecoration(
          labelText: AppStrings.bic,
          prefixIcon: Icon(CupertinoIcons.chart_bar)),
    );
  }

  Widget _userAddressTextField() {
    return TextFormField(
      controller: _addressCon,
      keyboardType: TextInputType.streetAddress,
      validator: AppValidator.validateAddress,
      decoration: const InputDecoration(
          labelText: AppStrings.address,
          prefixIcon: Icon(Icons.place_outlined)),
    );
  }

  Widget _payPalEmailTextField() {
    return TextFormField(
      controller: _payPalEmailCon,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: AppStrings.payPalEmail,
          prefixIcon: Icon(CupertinoIcons.mail)),
    );
  }

  Widget _imePayNumberTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _imePayNoCon,
      decoration: const InputDecoration(
          labelText: AppStrings.imePayNo,
          prefixIcon: Icon(Icons.account_balance_wallet_outlined)),
    );
  }

  Widget _khaltiNumberTextField() {
    return TextFormField(
      controller: _khaltiCon,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          labelText: AppStrings.khaltiNo,
          prefixIcon: Icon(Icons.account_balance_wallet_outlined)),
    );
  }

  Widget _eSewaNumberTextField() {
    return TextFormField(
      controller: _esewaCon,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          labelText: AppStrings.esewaNo,
          prefixIcon: Icon(Icons.account_balance_wallet_outlined)),
    );
  }

  Widget _spaceBtwInputFields() {
    return SizedBox(
      height: ComponentsSizes.spaceBtwInputFields,
    );
  }
}
