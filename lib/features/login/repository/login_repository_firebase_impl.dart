import 'package:car_rental_app_firebase/features/login/repository/login_repository.dart';
import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:car_rental_app_firebase/services/firebase_servies.dart';

class LoginRepositoryFirebaseImpl extends LoginRepository {

  final FirebaseServies _firebaseServies = FirebaseServies();
  @override
  Future<FirebaseResponseModel> login(payload) async {
    return await _firebaseServies.loginMethod(payload);

  }
}
