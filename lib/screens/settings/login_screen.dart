import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:user_manuals_app/util/database_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//**
// Flutter page for login/sign up
//
//
// */

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin =
      true; //Boolean for which page to show (sign up or login) defaults to login when true and sign up when false
  var _userEmail = ""; //User email used for sign up/sign in
  var _userPassword = ""; //User password used for sign up/sign in

  //**
  // Form submit for login/sign up
  // if _isLogin is true will submit a sign in request
  // else if _isLogin is false will create a new user with the submited email and password
  // */

  void submit() async {
    EasyLoading.show(status: 'loading...');
    final isValid = _form.currentState!.validate();
    DatabaseManager db = DatabaseManager();

    if (!isValid) {
      EasyLoading.dismiss();
      return;
    }

    _form.currentState!.save();

    if (_isLogin) {
      try {
        await _firebase.signInWithEmailAndPassword(
            email: _userEmail, password: _userPassword);
        EasyLoading.dismiss();
        EasyLoading.showSuccess(
          'Success!',
          duration: const Duration(milliseconds: 300),
        );
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed.')),
        );
      }
    } else {
      try {
        await _firebase.createUserWithEmailAndPassword(
            email: _userEmail, password: _userPassword);
        EasyLoading.dismiss();
        EasyLoading.showSuccess(
          'Success!',
          duration: const Duration(milliseconds: 300),
        );
        db.createFavorites();
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        // Todo: error handeling.
        if (error.code == "") {
        } else {
          EasyLoading.dismiss();
          // Display error to user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'Authentication failed.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  _isLogin ? "SignUp.login".tr() : "SignUp.signUp".tr(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cabin',
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        !value.contains("@")) {
                      return "SignUp.emailNotAvailable".tr();
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  decoration: InputDecoration(
                    labelText: "SignUp.password".tr(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return "SignUp.passwordError".tr();
                    }
                  },
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    backgroundColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  onPressed: submit,
                  child: Text(
                    _isLogin ? "SignUp.login".tr() : "SignUp.signUp".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? "SignUp.createAccount".tr()
                        : "SignUp.haveAccount".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
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
