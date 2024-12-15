import '../../data/auth/model/signup_req_params_for_auctioneer.dart';
import '../../domain/auth/entity/signup_req_params_for_auctioneer.dart';

class SignupReqParamsForAuctioneeMapper {
  static SignupReqParamsForAuctioneerModel toEntity(
      SignupReqParamsForAuctioneerEntity entity) {
    return SignupReqParamsForAuctioneerModel(
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      phoneNumber: entity.phoneNumber,
      profileImage: entity.profileImage,
      bankAccountName: entity.bankAccountName,
      bankAccountNumber: entity.bankAccountNumber,
      bankName: entity.bankName,
      swiftCode: entity.swiftCode,
      address: entity.address,
      paypalEmail: entity.paypalEmail,
      imepayNumber: entity.imepayNumber,
      khaltiNumber: entity.khaltiNumber,
      esewaNumber: entity.esewaNumber,
    );
  }
}
