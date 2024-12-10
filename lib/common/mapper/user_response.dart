import 'package:nepa_bid/data/auth/model/user_response.dart';
import 'package:nepa_bid/domain/auth/entity/user_response.dart';

class UserResponseMapper {
  static UserResponseEntity toEntity(UserResponseModel model) {
    return UserResponseEntity(
      success: model.success,
      message: model.message,
    );
  }
}
