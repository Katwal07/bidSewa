part of 'auth_imports.dart';

abstract class AuthRepository{
  Future<Either<Failure, UserResponseEntity>> signin(SigninReqParamsEntity params);
  Future<Either<Failure, UserResponseEntity>> signup(SignupReqParamsEntity params);
  Future<Either<Failure, UserResponseEntity>> signupForAuctioneer(SignupReqParamsForAuctioneerEntity params);
  Future<bool> isLoggedIn();
  Future<Either> loggedOut();
  Future<Either<Failure, AuctioneerUserEntity>> getAuctioneerUserProfile();
  Future<Either<Failure, BidderUserEntity>> getBidderUserProfile();
}