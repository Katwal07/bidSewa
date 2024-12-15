part of 'usecase_imports.dart';

class LoggedOut implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return await sl<AuthRepository>().loggedOut();
  }
}
