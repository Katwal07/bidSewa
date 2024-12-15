import 'package:nepa_bid/data/auth/model/user_response.dart';
import 'package:nepa_bid/domain/auth/entity/user_response.dart';

class UserResponseMapper {
  static UserResponseEntity toUserResponseEntity(
      UserResponseModel userResponseModel) {
    return UserResponseEntity(
      success: userResponseModel.success,
      message: userResponseModel.message,
      user: userResponseModel.user == null ? null : toUserEntity(userResponseModel.user!),
      token: userResponseModel.token,
    );
  }

  static UserEntity toUserEntity(UserModel userModel) {
    return UserEntity(
      profileImage: toProfileImageEntity(userModel.profileImage!),
      paymentMethods: userModel.paymentMethods == null ? null : toPaymentMethodEntity(userModel.paymentMethods!),
      id: userModel.id,
      username: userModel.username,
      password: userModel.password,
      email: userModel.email,
      address: userModel.address,
      phone: userModel.phone,
      role: userModel.role,
      unpaidCommission: userModel.unpaidCommission,
      auctionWon: userModel.auctionWon,
      trial: userModel.trial,
      sellCount: userModel.sellCount,
      moneySpent: userModel.moneySpent,
      createdAt: userModel.createdAt,
      v: userModel.v,
    );
  }

  static PaymentMethodsEntity toPaymentMethodEntity(
      PaymentMethodsModel paymentMethodsModel) {
    return PaymentMethodsEntity(
      bankTransfer: toBankTransferEntity(paymentMethodsModel.bankTransfer!),
      esewa: toEsewaEntity(paymentMethodsModel.esewa!),
      khalti: toKhaltiEntity(paymentMethodsModel.khalti!),
      imepay: toimePayEntity(paymentMethodsModel.imepay!),
      paypal: toPayPalEntity(paymentMethodsModel.paypal!),
    );
  }

  static BankTransferEntity toBankTransferEntity(
      BankTransferModel bankTransferModel) {
    return BankTransferEntity(
      bankAccountName: (bankTransferModel.bankAccountName == null)
          ? null
          : bankTransferModel.bankAccountName,
      bankAccountNumber: (bankTransferModel.bankAccountNumber == null)
          ? null
          : bankTransferModel.bankAccountNumber,
      bankName: (bankTransferModel.bankName == null)
          ? null
          : bankTransferModel.bankName,
      swiftCode: (bankTransferModel.swiftCode == null)
          ? null
          : bankTransferModel.swiftCode,
    );
  }

  static EsewaEntity toEsewaEntity(EsewaModel esewaModel) {
    return EsewaEntity(
      esewaNumber:
          (esewaModel.esewaNumber == null) ? null : esewaModel.esewaNumber,
    );
  }

  static KhaltiEntity toKhaltiEntity(KhaltiModel khaltiModel) {
    return KhaltiEntity(
      khaltiNumber:
          (khaltiModel.khaltiNumber == null) ? null : khaltiModel.khaltiNumber,
    );
  }

  static ImepayEntity toimePayEntity(ImepayModel imePayModel) {
    return ImepayEntity(
      imepayNumber:
          (imePayModel.imepayNumber == null) ? null : imePayModel.imepayNumber,
    );
  }

  static PaypalEntity toPayPalEntity(PaypalModel payPalModel) {
    return PaypalEntity(
      paypalEmail:
          (payPalModel.paypalEmail == null) ? null : payPalModel.paypalEmail,
    );
  }

  static ProfileImageEntity toProfileImageEntity(
      ProfileImageModel profileImageModel) {
    return ProfileImageEntity(
      publicId: profileImageModel.publicId,
      url: profileImageModel.url,
    );
  }
}
