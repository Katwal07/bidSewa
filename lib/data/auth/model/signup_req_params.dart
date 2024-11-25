
import 'dart:io';

class SignupReqParams {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String role;
  final File profileImage;

  SignupReqParams( {
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    this.role = "Bidder",
    required this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    };
  }
}
