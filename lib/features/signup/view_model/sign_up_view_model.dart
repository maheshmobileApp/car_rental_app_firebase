import 'package:car_rental_app_firebase/features/signup/model/sign_up_request_model.dart';
import 'package:car_rental_app_firebase/features/signup/model/sign_up_resoonse_model.dart';
import 'package:car_rental_app_firebase/features/signup/repository/sign_up_repository.dart';
import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpRepository repository;
  SignUpViewModel({required this.repository});

  Future<FirebaseResponseModel> signUpTheUser(SignUpRequestModel model) async {
    try {
      final response = await repository.signUp(model.toJson());
      return response;
    } catch (e) {
      return FirebaseResponseModel(
          isSuccess: true, message: e.toString(), data: null);
    }
  }
}
