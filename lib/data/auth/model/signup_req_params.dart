import 'dart:io';

class SignupReqParamsModel {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String role;
  final File profileImage;

  SignupReqParamsModel({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    this.role = "Bidder",
    required this.profileImage,
  });
}
