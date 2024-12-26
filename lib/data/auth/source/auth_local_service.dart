part of 'auth_api_imports.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<Either> loggedOut();
}

class AuthLocalServiceImpl extends AuthLocalService{
  @override
  Future<bool> isLoggedIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =  sharedPreferences.getString('token');
    debugPrint('Token: $token');
    if(token == null){
      return false;
    }else{
       return true;
    } 
  }
  
  @override
  Future<Either> loggedOut() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    return const Right(true);
  }

}