import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
       return false;
    } 
  }
  
  @override
  Future<Either> loggedOut() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    return const Right(true);
  }

}