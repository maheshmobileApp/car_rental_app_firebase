import 'package:car_rental_app_firebase/features/login/model/login_request_model.dart';
import 'package:car_rental_app_firebase/features/login/model/login_response_model.dart';
import 'package:car_rental_app_firebase/features/login/repository/login_repository.dart';
import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:car_rental_app_firebase/utils/local_storage_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  LoginRepository repository;
  LoginViewModel({required this.repository});

  Future<FirebaseResponseModel> loginApi(SignInRequestModel model) async {
    try {
      final response = await repository.login(model.toJson());
      if (response.isSuccess) {
        saveTheUserData(response.data);
      }
      return response;
      // saveTheUserData(modelData);
    } catch (e) {
      return FirebaseResponseModel(
          isSuccess: true, message: e.toString(), data: null);
    }
  }

  saveTheUserData(dynamic userResponse) async {
    if (userResponse is UserCredential) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          LocalStorageConstants.userId, userResponse.user!.uid);
      await prefs.setString(
          LocalStorageConstants.name, userResponse.user!.displayName ?? "");
      await prefs.setString(
          LocalStorageConstants.emmail, userResponse.user!.email ?? "");
    }
 
  }

  //Save the user information like -> id, name, token and email
}
