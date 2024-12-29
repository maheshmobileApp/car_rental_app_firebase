import 'dart:io';

import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:car_rental_app_firebase/utils/server_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseServies {
  Future<FirebaseResponseModel> signUpMethod(Map<String, dynamic> data) async {
    // name, email, password data from signup page
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data["email"], password: data["password"]);
      return FirebaseResponseModel(
          isSuccess: true,
          message: "Succfully Register The user",
          data: response);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return FirebaseResponseModel(
            isSuccess: false,
            message: "The password provided is too weak.",
            data: null);
      } else if (e.code == 'email-already-in-use') {
        return FirebaseResponseModel(
            isSuccess: false,
            message: "The account already exists for that email.",
            data: null);
      } else {
        return FirebaseResponseModel(
            isSuccess: false, message: e.toString(), data: null);
      }
    } catch (e) {
      return FirebaseResponseModel(
          isSuccess: false, message: e.toString(), data: null);
    }
  }

  Future<FirebaseResponseModel> loginMethod(Map<String, dynamic> data) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data["email"], password: data["password"]);
      return FirebaseResponseModel(
          isSuccess: true, message: "Succfully Login The user", data: response);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return FirebaseResponseModel(
            isSuccess: false,
            message: "No user found for that email.",
            data: null);
      } else if (e.code == 'wrong-password') {
        return FirebaseResponseModel(
            isSuccess: false,
            message: "Wrong password provided for that user.",
            data: null);
      } else {
        return FirebaseResponseModel(
            isSuccess: false, message: e.toString(), data: null);
      }
    } catch (e) {
      return FirebaseResponseModel(
          isSuccess: false, message: e.toString(), data: null);
    }
  }

  Future<FirebaseResponseModel> saveTheUserData(
      Map<String, dynamic> data) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(ServerConstants.userCollection);
    await users.add(data).then((value) {
      return FirebaseResponseModel(
          isSuccess: true, message: "Succfully Add The user", data: value);
    }).catchError((error) {
      return FirebaseResponseModel(
          isSuccess: false, message: error.toString(), data: null);
    });
    return FirebaseResponseModel(
        isSuccess: false, message: "Something went wrong", data: null);
  }

  Future<FirebaseResponseModel> saveTheCarData(
      Map<String, dynamic> data) async {
    CollectionReference cars =
        FirebaseFirestore.instance.collection(ServerConstants.carsCollection);
    await cars.add(data).then((value) {
      return FirebaseResponseModel(
          isSuccess: true, message: "Succfully Add The car", data: value);
    }).catchError((error) {
      return FirebaseResponseModel(
          isSuccess: false, message: error.toString(), data: null);
    });
    return FirebaseResponseModel(
        isSuccess: false, message: "Something went wrong", data: null);
  }

  Future<FirebaseResponseModel> uploadTheImage(XFile image) async {
    final FirebaseStorage storage = FirebaseStorage.instance;

    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageRef = storage.ref().child('uploads/$fileName');
    try {
      // Upload the file
      await storageRef.putFile(File(image.path));
      // Get the download URL
      final String downloadURL = await storageRef.getDownloadURL();
      return FirebaseResponseModel(
          isSuccess: true,
          message: "Succfully Upload The image",
          data: downloadURL);
    } catch (e) {
      return FirebaseResponseModel(
          isSuccess: false, message: e.toString(), data: null);
    }
  }

  Future<FirebaseResponseModel> getCars() async {

    CollectionReference cars =
        FirebaseFirestore.instance.collection(ServerConstants.carsCollection);

    try {
      QuerySnapshot querySnapshot = await cars.get();
      return FirebaseResponseModel(
          isSuccess: true,
          message: "Succfully Get The cars",
          data: querySnapshot.docs);
    } catch (e) {
      return FirebaseResponseModel(
          isSuccess: false, message: e.toString(), data: null);
    }
  }
  
}
