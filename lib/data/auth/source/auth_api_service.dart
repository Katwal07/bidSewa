part of 'auth_api_imports.dart';

abstract class AuthApiService {
  Future<Either<AppException, UserResponseModel>> signin(
      SigninReqParamsModel params);
  Future<Either<AppException, UserResponseModel>> signup(
      SignupReqParamsModel params);
  Future<Either> signupForAuctioneer(SignupReqParamsForAuctioneerModel params);
  Future<Either<AppException, AuctioneerUserModel>> getAuctioneerUserProfile();
  Future<Either<AppException, BidderUserModel>> getBidderUserProfile();
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either<AppException, UserResponseModel>> signin(
      SigninReqParamsModel params) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      var response = await sl<ApiClient>().postRequest(
        path: ApiEndpointUrls.login,
        body: params.toMap(),
      );
      
      final userResponseModel = UserResponseModel.fromJson(response.data);
      pref.setString('userId', userResponseModel.user!.id!);
      debugPrint('User ID: ${userResponseModel.user!.id}');
      return Right(userResponseModel);

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(message: AppStrings.unableToConnectToServer);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: AppStrings.noInternet);
      }
      if (e.response?.statusCode == 401) {
        throw UnAuthorizedException(
            message: e.response?.data['message'] ?? AppStrings.invalidCredential);
      }
      throw ServerException(
          message: e.response?.data['message'] ?? AppStrings.anErrorOccured);
    }
  }

  @override
  Future<Either<AppException, UserResponseModel>> signup(
      SignupReqParamsModel params) async {
    try {
      final String fileExtension =
          params.profileImage.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp'].contains(fileExtension)) {
        return Left(
          ValidationException(
            message: AppStrings.invalidFileType,
          ),
        );
      }

      final FormData formData = FormData.fromMap(
        {
          'username': params.fullName,
          'email': params.email,
          'password': params.password,
          'phone': params.phoneNumber,
          'role': params.role,
          'profileImage': await MultipartFile.fromFile(
            params.profileImage.path,
            filename: params.profileImage.path.split('/').last,
            contentType: MediaType('image', fileExtension),
          ),
        },
      );

      var response = await sl<ApiClient>().postRequest(
        path: ApiEndpointUrls.register,
        body: formData,
      );
      final userResponse = UserResponseModel.fromJson(response.data);
      return Right(userResponse);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(message: AppStrings.unableToConnectToServer);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: AppStrings.noInternet);
      }
      if (e.response?.statusCode == 401) {
        throw UnAuthorizedException(
            message: e.response?.data['message'] ?? AppStrings.invalidCredential);
      }
      throw ServerException(
          message: e.response?.data['message'] ?? AppStrings.anErrorOccured);
    }
  }

  @override
  Future<Either<AppException, UserResponseModel>> signupForAuctioneer(
      SignupReqParamsForAuctioneerModel params) async {
    try {
      final String fileExtension =
          params.profileImage.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp'].contains(fileExtension)) {
        return Left(
          ValidationException(
            message: AppStrings.invalidFileType,
          ),
        );
      }

      final FormData formData = FormData.fromMap(
        {
          'username': params.fullName,
          'email': params.email,
          'password': params.password,
          'phone': params.phoneNumber,
          'role': params.role,
          'bankAccountName': params.bankAccountName,
          'bankAccountNumber': params.bankAccountNumber,
          'bankName': params.bankName,
          'swiftCode': params.swiftCode,
          'address': params.address,
          'paypalEmail': params.paypalEmail,
          'imepayNumber': params.imepayNumber,
          'khaltiNumber': params.khaltiNumber,
          'esewaNumber': params.esewaNumber,
          'profileImage': await MultipartFile.fromFile(
            params.profileImage.path,
            filename: params.profileImage.path.split('/').last,
            contentType: MediaType('image', fileExtension),
          ),
        },
      );

      var response = await sl<ApiClient>().postRequest(
        path: ApiEndpointUrls.register,
        body: formData,
      );
      final userResponse = UserResponseModel.fromJson(response.data);
      return Right(userResponse);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(message: AppStrings.unableToConnectToServer);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: AppStrings.noInternet);
      }
      if (e.response?.statusCode == 401) {
        throw UnAuthorizedException(
            message: e.response?.data['message'] ?? AppStrings.invalidCredential);
      }
      throw ServerException(
          message: e.response?.data['message'] ?? AppStrings.anErrorOccured);
    }
  }

  @override
  Future<Either<AppException, AuctioneerUserModel>> getAuctioneerUserProfile() async {
    try {
      var response = await sl<ApiClient>()
          .getRequest(path: ApiEndpointUrls.getUserProfile);
      var userProfile = AuctioneerUserModel.fromJson(response.data);
      return Right(userProfile);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(message: AppStrings.unableToConnectToServer);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: AppStrings.noInternet);
      }
      if (e.response?.statusCode == 401) {
        throw UnAuthorizedException(
            message: e.response?.data['message'] ?? AppStrings.invalidCredential);
      }
      throw ServerException(
          message: e.response?.data['message'] ?? AppStrings.anErrorOccured);
    }
  }
  
  @override
  Future<Either<AppException, BidderUserModel>> getBidderUserProfile() async{
    try {
      var response = await sl<ApiClient>()
          .getRequest(path: ApiEndpointUrls.getUserProfile);
      var userProfile = BidderUserModel.fromJson(response.data);
      return Right(userProfile);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(message: AppStrings.unableToConnectToServer);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: AppStrings.noInternet);
      }
      if (e.response?.statusCode == 401) {
        throw UnAuthorizedException(
            message: e.response?.data['message'] ?? AppStrings.invalidCredential);
      }
      throw ServerException(
          message: e.response?.data['message'] ?? AppStrings.anErrorOccured);
    }
  }
}
