import 'package:car_rental_app_firebase/features/signup/repository/sign_up_repository.dart';
import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:car_rental_app_firebase/services/firebase_servies.dart';

class SignUpRepositoryImplFirebase extends SignUpRepository {
  final FirebaseServies _firebaseServies = FirebaseServies();
  @override
  Future<FirebaseResponseModel> signUp(payload) async {
    return await _firebaseServies.signUpMethod(payload);
  }
  
  @override
  Future<FirebaseResponseModel> saveTheUserData(payload) async {
   return await _firebaseServies.saveTheUserData(payload);
  }
}
