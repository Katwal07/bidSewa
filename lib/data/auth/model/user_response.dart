
class UserResponseModel {
  final bool success;
  final String message;

  UserResponseModel({
    required this.success,
    required this.message,
  });

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      success: map['success'] as bool,
      message: map['message'] as String,
    );
  }

}
