import 'package:car_rental_app_firebase/features/cars/repository/car_repository.dart';
import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:car_rental_app_firebase/services/firebase_servies.dart';

class CarRepositoryFirebase extends CarRepository {
  final FirebaseServies _firebaseServies = FirebaseServies();
  @override
  Future addCar(data) {
    // TODO: implement addCar
    throw UnimplementedError();
  }

  @override
  Future<FirebaseResponseModel> getCarsList() async {
    return await _firebaseServies.getCars();
  }
}
