import 'package:car_rental_app_firebase/services/firebase_response_model.dart';

abstract class LoginRepository {
  Future<FirebaseResponseModel> login(dynamic payload);

}