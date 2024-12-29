import 'package:car_rental_app_firebase/features/add_car/repository/add_car_repository.dart';
import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:car_rental_app_firebase/services/firebase_servies.dart';
import 'package:image_picker/image_picker.dart';

class AddCareRepositoryFirebaseImpl extends AddCarRepository {
  final FirebaseServies _firebaseServies = FirebaseServies();
  @override
  Future<FirebaseResponseModel> addCar(data) async {
    return await _firebaseServies.saveTheCarData(data);
  }

  @override
  Future<FirebaseResponseModel> uploadImage(XFile image) async {
    return await _firebaseServies.uploadTheImage(image);
  
  }
}
