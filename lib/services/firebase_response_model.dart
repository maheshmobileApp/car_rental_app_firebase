class FirebaseResponseModel {
  bool isSuccess;
  String message;
  dynamic data;

  FirebaseResponseModel(
      {required this.isSuccess, required this.message, required this.data});
}
