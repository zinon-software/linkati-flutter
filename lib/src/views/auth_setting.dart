import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'auth/login_view.dart';
import 'auth/signup_view.dart';

class AuthScreenControl extends StatefulWidget {
  const AuthScreenControl({ Key? key }) : super(key: key);

  @override
  State<AuthScreenControl> createState() => _AuthScreenControlState();
}

class _AuthScreenControlState extends State<AuthScreenControl> {

final AuthController postController = Get.put(AuthController(), permanent: true);

   bool _isToggle = true;
  void toggleScreen(){
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isToggle){
      return SignUpView(toggleScreen: toggleScreen);
    } else{
      return LoginView(toggleScreen: toggleScreen);
    }
  }
}