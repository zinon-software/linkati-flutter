import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key, required this.toggleScreen}) : super(key: key);

  static const String id = "LOGIN";
  final Function toggleScreen;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    throw ("jhugjygyu");
  }
  @override
  Widget build(BuildContext context) {
    final AuthController loginController = Get.find();
    final _formKey = GlobalKey<FormState>();
    String? _email, _passwod;

    _submit() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
         loginController.signIn(
          _email!.trim(),
          _passwod!.trim(),
        );

        // logging in the user w/ Api
      }
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Billabong',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sign in with your email and password  \nor continue with social media.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _email = input!,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter your email",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (input) => !input!.contains('@')
                              ? 'Please enter avalid email'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            labelText: 'Password',
                            hintText: "Enter your Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (input) => input!.length < 4
                              ? 'Must be least 4 characters'
                              : null,
                          onSaved: (input) => _passwod = input!,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
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
                            LoginView.id,
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
                          const Text("Don't have an account ?"),
                          TextButton(
                            onPressed: () => widget.toggleScreen(),
                            child: const Text("RGISTER"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
