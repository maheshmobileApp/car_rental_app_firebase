import 'package:car_rental_app_firebase/services/firebase_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
