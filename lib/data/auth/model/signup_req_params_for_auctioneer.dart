import 'dart:io';

class SignupReqParamsForAuctioneer {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String role;
  final File profileImage;
  final String bankAccountName;
  final String bankAccountNumber;
  final String bankName;
  final String swiftCode;
  final String address;
  final String paypalEmail;
  final String imepayNumber;
  final String khaltiNumber;
  final String esewaNumber;

  SignupReqParamsForAuctioneer({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.role = "Auctioneer",
    required this.profileImage,
    required this.bankAccountName,
    required this.bankAccountNumber,
    required this.bankName,
    required this.swiftCode,
    required this.address,
    required this.paypalEmail,
    required this.imepayNumber,
    required this.khaltiNumber,
    required this.esewaNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'role': role,
      'profileImage': profileImage,
      'bankAccountName': bankAccountName,
      'bankAccountNumber': bankAccountNumber,
      'bankName': bankName,
      'swiftCode': swiftCode,
      'address': address,
      'paypalEmail': paypalEmail,
      'imepayNumber': imepayNumber,
      'khaltiNumber': khaltiNumber,
      'esewaNumber': esewaNumber,
    };
  }
}
