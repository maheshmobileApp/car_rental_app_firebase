import 'package:car_rental_app_firebase/features/add_car/model/addcar_reponse_model.dart';
import 'package:car_rental_app_firebase/features/add_car/model/addcar_request_model.dart';
import 'package:car_rental_app_firebase/features/add_car/repository/add_car_repository.dart';
import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCarViewModel extends ChangeNotifier {
  AddCarRepository repository;
  final List<int> yearsList = List.generate(
    DateTime.now().year - 1901 + 1,
    (index) => 1901 + index,
  );

  List<String> transmissionList = [
    'Manual Transmission',
    'Automatic Transmission',
    'Continuously Variable Transmission (CVT)',
    'Dual-Clutch Transmission (DCT)',
    'Semi-Automatic Transmission',
    'Tiptronic Transmission',
    'Direct Shift Gearbox (DSG)',
    'Electric Vehicle Transmission (EVT)',
  ];
  List<String> fuelTypeList = [
    'Petrol',
    'Diesel',
    'Electric',
    'Hybrid (Petrol + Electric)',
    'Plug-in Hybrid (PHEV)',
    'CNG (Compressed Natural Gas)',
    'LPG (Liquefied Petroleum Gas)',
    'Hydrogen (Fuel Cell)',
    'Ethanol (Flex Fuel)',
    'Biodiesel',
  ];

  String? selectedTransmission;
  String? selectedFuelType;
  int? selectedYear;
  XFile? selectedImage;

  AddCarViewModel({required this.repository});

  void setSelectedTransmission(String? value) {
    selectedTransmission = value;
    notifyListeners();
  }

  void setSelectedFuelType(String? value) {
    selectedFuelType = value;
    notifyListeners();
  }

  void setSelectedYear(int? value) {
    selectedYear = value;
    notifyListeners();
  }

  void setSelectedImage(XFile? value) {
    selectedImage = value;
    notifyListeners();
  }

  Future<FirebaseResponseModel> addCar(AddCarRequestModel requestModel) async {
    var addCarPayload = requestModel.toJson();
    addCarPayload['image'] = await uploadImage(selectedImage!);
    try {
      final response = await repository.addCar(addCarPayload);

      return response;
    } catch (e) {
      return FirebaseResponseModel(
          isSuccess: false, message: e.toString(), data: null);
    }
  }

  Future<String> uploadImage(XFile image) async {
    final response = await repository.uploadImage(image);
    return response.data;
  }
}
/*
addCarPayload
 */