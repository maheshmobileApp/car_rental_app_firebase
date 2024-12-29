import 'package:image_picker/image_picker.dart';

abstract class AddCarRepository {
  Future<dynamic> addCar(dynamic data);
  Future<dynamic> uploadImage(XFile image);
}