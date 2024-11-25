part of '../pages/auth_imports.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _fullNameCon = TextEditingController();

  final TextEditingController _emailCon = TextEditingController();

  final TextEditingController _passwordCon = TextEditingController();

  final TextEditingController _phoneNumberCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<SignupCubit, SignupState>(
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
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Email TextField
                          _emailTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Password TextField
                          _passwordTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// PhoneNumber TextField
                          _phoneNumberTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Upload ProfileImage
                          _uploadProfileImage(context),

                          /// Select Role
                          _selectRole(context),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Signup Button
                          _signupButton(context),
                          const SizedBox(
                            height: ComponentsSizes.md,
                          ),

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
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Email TextField
                          _emailTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Password TextField
                          _passwordTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// PhoneNumber TextField
                          _phoneNumberTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// BankAccount Holder TextField
                          _bankAccountHolderNameTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// BankAccount Number TextField
                          _bankAccountNumberTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Bank Name TextField
                          _bankNameTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Bank IdentifierCode TextField
                          _bankIdentifierCodeTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// UserAddress TextField
                          _userAddressTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// PayPal Email TextField
                          _payPalEmailTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// ImePay Number TextField
                          _imePayNumberTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Khalti Number TextField
                          _khaltiNumberTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Esewa Number TextField
                          _eSewaNumberTextField(),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Upload Profile Image
                          _uploadProfileImage(context),

                          /// SelectRole
                          _selectRole(context),
                          SizedBox(
                            height: ComponentsSizes.spaceBtwInputFields,
                          ),

                          /// Signup Button
                          _signupButton(context),
                          const SizedBox(
                            height: ComponentsSizes.md,
                          ),

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
      decoration: const InputDecoration(
          labelText: AppStrings.enterFullName,
          prefixIcon: Icon(CupertinoIcons.person)),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: _emailCon,
      decoration: const InputDecoration(
          labelText: AppStrings.enterEmail,
          prefixIcon: Icon(CupertinoIcons.mail_solid)),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordCon,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          CupertinoIcons.lock_fill,
        ),
        suffixIcon: Icon(
          CupertinoIcons.eye_fill,
        ),
        labelText: AppStrings.enterPass,
      ),
    );
  }

  Widget _phoneNumberTextField() {
    return TextFormField(
      controller: _phoneNumberCon,
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
                    icon: const Icon(Icons.image)),
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
                  child: Text("Select Image"),
                ),
              ),
            ],
          );
        }
        if (state is ImageLoadingState) {
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
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
              ),
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
                    topRight: Radius.circular(ComponentsSizes.buttonRadius),
                    bottomRight: Radius.circular(ComponentsSizes.buttonRadius),
                  ),
                ),
                child: const Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          );
        }
        if (state is ImageLoadedState) {
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
                    context.read<ImagePickerCubit>().reset();
                    context.read<ImagePickerCubit>().pickImage();
                  },
                  icon: const Icon(Icons.image),
                ),
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
                child: Center(
                  child: Text(state.displayName),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _selectRole(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
                value: state.checkbox1,
                onChanged: (value) {
                  if (value != null) {
                    context.read<SignupCubit>().toggleCheckbox1(value);
                  }
                }),
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
                  context.read<SignupCubit>().toggleCheckbox2(value);
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
        child: ElevatedButton(
          onPressed: () {
            final String? profileImagePath =
                imagePickerCubit.getSelectedImagePath();

            debugPrint("Profile image path: $profileImagePath");

            if (profileImagePath == null || profileImagePath.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select a profile image")),
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
          },
          child: Text(
            AppStrings.singup,
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
        Text(
          AppStrings.signin,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: AppColors.lightPrimaryColor),
        ),
      ],
    );
  }

  Widget _bankAccountHolderNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.bankAccountHolderName,
          prefixIcon: Icon(CupertinoIcons.person_fill)),
    );
  }

  Widget _bankAccountNumberTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.bankAccountNumber,
          prefixIcon: Icon(CupertinoIcons.creditcard)),
    );
  }

  Widget _bankNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.bankName,
          prefixIcon: Icon(CupertinoIcons.building_2_fill)),
    );
  }

  Widget _bankIdentifierCodeTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.bic,
          prefixIcon: Icon(CupertinoIcons.chart_bar)),
    );
  }

  Widget _userAddressTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.address, prefixIcon: Icon(CupertinoIcons.map)),
    );
  }

  Widget _payPalEmailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.payPalEmail,
          prefixIcon: Icon(CupertinoIcons.mail)),
    );
  }

  Widget _imePayNumberTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.imePayNo,
          prefixIcon: Icon(CupertinoIcons.list_number)),
    );
  }

  Widget _khaltiNumberTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.khaltiNo,
          prefixIcon: Icon(CupertinoIcons.list_number)),
    );
  }

  Widget _eSewaNumberTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: AppStrings.esewaNo,
          prefixIcon: Icon(CupertinoIcons.list_number)),
    );
  }
}
