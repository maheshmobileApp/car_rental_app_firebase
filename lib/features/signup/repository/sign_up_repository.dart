import 'package:car_rental_app_firebase/services/firebase_response_model.dart';

abstract class SignUpRepository {
  Future<FirebaseResponseModel> signUp(dynamic payload);
  Future<FirebaseResponseModel> saveTheUserData(dynamic payload);
}