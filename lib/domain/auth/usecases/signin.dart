import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/data/auth/model/signin_req_params.dart';
import 'package:nepa_bid/domain/auth/repositories/auth.dart';
import 'package:nepa_bid/service_locator.dart';

class SignInUseCase implements UseCase<Either, SigninReqParams> {

  @override
  Future<Either> call({SigninReqParams ? param}) async {
    return await sl<AuthRepository>().signin(param!);
  }
}