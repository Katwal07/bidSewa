import 'package:nepa_bid/data/auth/model/signin_req_params.dart';
import 'package:nepa_bid/domain/auth/entity/signin_req_params.dart';

class SigninReqParamsMapper {
  static SigninReqParamsModel toEntity(SigninReqParamsEntity entity) {
    return SigninReqParamsModel(
      email: entity.email,
      password: entity.password,
    );
  }
}
