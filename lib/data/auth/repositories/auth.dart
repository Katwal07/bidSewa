part of 'auth_imports.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, UserResponseEntity>> signin(
      SigninReqParamsEntity params) async {
    try {
      Either result = await sl<AuthApiService>()
          .signin(SigninReqParamsMapper.toEntity(params));
      return result.fold((error) {
        return Left(error);
      }, (data) async {
        if (data.success) {
          final token = data.token;

          await TokenService.saveToken(token);
        }
        final userResponse = UserResponseMapper.toUserResponseEntity(data);
        return Right(userResponse);
      });
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    } catch (e) {
      return Left(UnExceptedFailure(message: "An unknown error occured"));
    }
  }

  @override
  Future<Either<Failure, UserResponseEntity>> signup(
      SignupReqParamsEntity params) async {
    try {
      Either result = await sl<AuthApiService>()
          .signup(SignupReqParamsMapper.toEntity(params));
      return result.fold((error) {
        return Left(error);
      }, (data) async {
        final userResponse = UserResponseMapper.toUserResponseEntity(data);
        return Right(userResponse);
      });
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    } catch (e) {
      return Left(UnExceptedFailure(message: "An unknown error occured"));
    }
  }

  @override
  Future<Either<Failure, UserResponseEntity>> signupForAuctioneer(
      SignupReqParamsForAuctioneerEntity params) async {
    try {
      Either result = await sl<AuthApiService>().signupForAuctioneer(
          SignupReqParamsForAuctioneeMapper.toEntity(params));
      return result.fold((error) {
        return Left(error);
      }, (data) {
        final userResponse = UserResponseMapper.toUserResponseEntity(data);
        return Right(userResponse);
      });
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    } catch (e) {
      return Left(UnExceptedFailure(message: "An unknown error occured"));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> loggedOut() async {
    return await sl<AuthLocalService>().loggedOut();
  }

  @override
  Future<Either<Failure, AuctioneerUserEntity>>
      getAuctioneerUserProfile() async {
    try {
      Either returnedData =
          await sl<AuthApiService>().getAuctioneerUserProfile();
      return returnedData.fold((error) {
        return Left(error);
      }, (data) {
        var userProfile = AuctionUserMapper.toAuctionUserEntity(data);
        return Right(userProfile);
      });
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    } catch (e) {
      return Left(UnExceptedFailure(message: "An unknown error occured"));
    }
  }
}
