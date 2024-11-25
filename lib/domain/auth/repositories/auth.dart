import 'package:dartz/dartz.dart';
import '../../../data/auth/model/signin_req_params.dart';
import '../../../data/auth/model/signup_req_params.dart';

abstract class AuthRepository{
  Future<Either> signin(SigninReqParams params);
  Future<Either> signup(SignupReqParams params);
  Future<bool> isLoggedIn();
  Future<Either> loggedOut();
}