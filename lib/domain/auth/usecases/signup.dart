import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auth/repositories/auth.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../data/auth/model/signup_req_params.dart';

class SignUpUseCase implements UseCase<Either, SignupReqParams> {

  @override
  Future<Either> call({SignupReqParams ? param}) async {
    return sl<AuthRepository>().signup(param!);
  }
}