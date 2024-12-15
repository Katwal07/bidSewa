import 'package:dartz/dartz.dart';
import 'package:nepa_bid/domain/auth/entity/user_response.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../entity/signin_req_params.dart';
import '../entity/signup_req_params.dart';
import '../entity/signup_req_params_for_auctioneer.dart';
import '../repositories/auth_imports.dart';

part 'get_user_profile.dart';
part 'is_logged_in.dart';
part 'logged_out.dart';
part 'signin.dart';
part 'signup_for_auctioneer.dart';
part 'signup.dart';