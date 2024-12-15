part of 'usecase_imports.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}
