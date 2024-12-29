import 'package:car_rental_app_firebase/routes/routes_constants.dart';
import 'package:car_rental_app_firebase/services/navigation_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prfole"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); //Sign out from firebase
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear(); //clear the all local storage data
              NavigationServices().replaceAll(
                  RoutesConstants.loginScreen); //navigate to login screen
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text("Profile"),
      ),
    );
  }
}