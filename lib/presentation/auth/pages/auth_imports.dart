
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/widgets/button/reactive_button.dart';
import 'package:nepa_bid/presentation/auth/bloc/image_picker/image_picker_cubit.dart';

import '../../../common/bloc/button_bloc/button_cubit.dart';
import '../../../common/res/size_configs.dart';
import '../../../core/config/assets/app_images.dart';
import '../../../core/config/routes/routes_name.dart';
import '../../../core/config/theme/colors.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/text_string.dart';
import '../../../data/auth/model/signin_req_params.dart';
import '../../../data/auth/model/signup_req_params.dart';
import '../../../domain/auth/usecases/signin.dart';
import '../../../domain/auth/usecases/signup.dart';
import '../../../service_locator.dart';
import '../../home/pages/home.dart';
import '../bloc/image_picker/image_picker_state.dart';
import '../bloc/signup/signup_cubit.dart';
import '../bloc/signup/signup_state.dart';

part '../pages/login_or_signup/choose_auth.dart';
part '../pages/login/login.dart';
part '../pages/signup/signup.dart';
part '../widgets/signup_form.dart';