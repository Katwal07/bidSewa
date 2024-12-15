import '../../data/auth/model/signup_req_params.dart';
import '../../domain/auth/entity/signup_req_params.dart';

class SignupReqParamsMapper {
  static SignupReqParamsModel toEntity(SignupReqParamsEntity entity) {
    return SignupReqParamsModel(
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      password: entity.password,
      profileImage: entity.profileImage,
    );
  }
}
