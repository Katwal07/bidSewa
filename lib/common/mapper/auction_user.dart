import 'package:nepa_bid/data/auth/model/auctionner_user.dart';
import 'package:nepa_bid/domain/auth/entity/auctioneer_user.dart';

class AuctionUserMapper {
  static AuctioneerUserEntity toAuctionUserEntity(
      AuctioneerUserModel auctionUserModel) {
    return AuctioneerUserEntity(
      success: auctionUserModel.success,
      message: auctionUserModel.message,
      user: toAuctionUserClassEntity(auctionUserModel.user!),
      token: auctionUserModel.token,
    );
  }

  static AuctioneerUserClassEntity toAuctionUserClassEntity(
      AuctioneerUserClassModel auctionUserClassModel) {
    return AuctioneerUserClassEntity(
      profileImage: toProfileImageEntity(auctionUserClassModel.profileImage!),
      paymentMethods:
          toPayemntMethodEntity(auctionUserClassModel.paymentMethods!),
      id: auctionUserClassModel.id,
      username: auctionUserClassModel.username,
      password: auctionUserClassModel.password,
      email: auctionUserClassModel.email,
      address: auctionUserClassModel.address,
      phone: auctionUserClassModel.phone,
      role: auctionUserClassModel.role,
      unpaidCommission: auctionUserClassModel.unpaidCommission,
      auctionWon: auctionUserClassModel.auctionWon,
      trial: auctionUserClassModel.trial,
      sellCount: auctionUserClassModel.sellCount,
      moneySpent: auctionUserClassModel.moneySpent,
      createdAt: auctionUserClassModel.createdAt,
      v: auctionUserClassModel.v,
    );
  }

  static PaymentMethodsEntity toPayemntMethodEntity(
      PaymentMethodsModel paymentMethodsModel) {
    return PaymentMethodsEntity(
      bankTransfer: toBankTransferEntity(paymentMethodsModel.bankTransfer!),
      esewa: toEsewaEntity(paymentMethodsModel.esewa!),
      khalti: toKhaltiEntity(paymentMethodsModel.khalti!),
      imepay: toImepayEntity(paymentMethodsModel.imepay!),
      paypal: toPaypalEntity(paymentMethodsModel.paypal!),
    );
  }

  static ProfileImageEntity toProfileImageEntity(
      ProfileImageModel profileImageModel) {
    return ProfileImageEntity(
      publicId: profileImageModel.publicId,
      url: profileImageModel.url,
    );
  }

  static BankTransferEntity toBankTransferEntity(
      BankTransferModel bankTransferModel) {
    return BankTransferEntity(
      bankAccountName: bankTransferModel.bankAccountName,
      bankAccountNumber: bankTransferModel.bankAccountNumber,
      bankName: bankTransferModel.bankName,
      swiftCode: bankTransferModel.swiftCode,
    );
  }

  static EsewaEntity toEsewaEntity(EsewaModel esewaModel) {
    return EsewaEntity(
      esewaNumber: esewaModel.esewaNumber,
    );
  }

  static ImepayEntity toImepayEntity(ImepayModel imepayModel) {
    return ImepayEntity(
      imepayNumber: imepayModel.imepayNumber,
    );
  }

  static KhaltiEntity toKhaltiEntity(KhaltiModel khaltiModel) {
    return KhaltiEntity(
      khaltiNumber: khaltiModel.khaltiNumber,
    );
  }

  static PaypalEntity toPaypalEntity(PaypalModel paypalModel) {
    return PaypalEntity(
      paypalEmail: paypalModel.paypalEmail,
    );
  }
}
