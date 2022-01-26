import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key, required this.toggleScreen}) : super(key: key);

  static const String id = "SINGNUP";
  final Function toggleScreen;

  @override
  Widget build(BuildContext context) {
    final AuthController signupController = Get.find();
    final _formKey = GlobalKey<FormState>();
    String? _username, _email, _password;

    _submit() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        signupController.signUp(
          _username!.trim(),
          _email!.trim(),
          _password!.trim(),
        );
        // sign up in the user w/ API
      }
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "إنشاء حساب",
                style: TextStyle(
                  fontFamily: "Billabong",
                  fontSize: 50.0,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.person),
                          hintText: "Enter your Username",
                        ),
                        validator: (input) => input!.trim().isEmpty
                            ? 'Please enter avalid Username'
                            : null,
                        onSaved: (input) => _username = input!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                          hintText: "Enter your Email",
                        ),
                        validator: (input) => !input!.contains('@')
                            ? 'Please enter avalid email'
                            : null,
                        onSaved: (input) => _email = input!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.password),
                          hintText: "Enter your Password",
                        ),
                        validator: (input) => input!.length < 6
                            ? 'Must be least 6 characters'
                            : null,
                        onSaved: (input) => _password = input!,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 250.0,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: _submit,
                        color: Colors.blue,
                        padding: const EdgeInsets.all(10.0),
                        // minWidth:
                        //     signupProvider.isLoading ? null : double.infinity,
                        // child: signupProvider.isLoading
                        //     ? CircularProgressIndicator(
                        //         valueColor: new AlwaysStoppedAnimation<Color>(
                        //             Colors.white),
                        //       )
                        //     :
                        child: const Text(
                          id,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Billabong",
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do have an account ?"),
                        TextButton(
                          onPressed: () => toggleScreen(),
                          child: const Text(
                            "Back to LOGIN",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
