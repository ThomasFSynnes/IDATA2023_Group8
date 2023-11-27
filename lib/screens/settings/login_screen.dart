import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';

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

  var _isLogin = false;
  var _userEmail = "";
  var _userPassword = "";

  void submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    if (_isLogin) {
      try {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _userEmail, password: _userPassword);
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed.')),
        );
      }
    } else {
      try {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: _userEmail, password: _userPassword);
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        // Todo: error handeling.
        if (error.code == "") {
        } else {
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Login"),
      ),
      body: Padding(
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
                decoration: InputDecoration(
                  labelText: "SignUp.password".tr(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return "SignUp.passwordError".tr(); //todo: tr
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
              ), //todo: tr
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
    );
  }
}
