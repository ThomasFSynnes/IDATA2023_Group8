import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _newEmail = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Text(
          "ChangeEmail.changeEmail".tr(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                decoration: InputDecoration(
                    labelText: "ChangeEmail.newEmail".tr(),
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "ChangeEmail.pleaseEnterEmail".tr();
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _newEmail = value;
                  });
                },
              ),
              TextFormField(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                decoration: InputDecoration(
                  labelText: "ChangeEmail.password".tr(),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "ChangeEmail.pleaseEnterPass".tr();
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  backgroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _changeEmail();
                  }
                },
                child: Text(
                  "ChangeEmail.changeEmail".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changeEmail() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _password,
        );
        EasyLoading.show(status: 'loading...');
        await user.reauthenticateWithCredential(credential);

        await user.updateEmail(_newEmail);

        EasyLoading.dismiss();
        EasyLoading.showSuccess(
          "ChangeEmail.changeEmailSuccess".tr(),
        );
        Navigator.of(context).pop();
      } else {
        EasyLoading.showError(
          "ChangeEmail.userNotFound".tr(),
        );
      }
    } on FirebaseAuthException catch (error) {
      EasyLoading.showError(
        error.message ?? "ChangeEmail.changeFailed".tr(),
      );
    }
  }
}
