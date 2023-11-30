import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';

//Flutter page for changing user password

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _oldPassword = ''; //Current user password used to authenticate
  String _newPassword = ''; //Password user want to change to

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
          "ChangePassword.changePassword".tr(),
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
                //input for old passsword
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  labelText: "ChangePassword.oldPassword".tr(),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  //validate to check if empty
                  if (value == null || value.isEmpty) {
                    return "ChangePassword.pleaseOld".tr();
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _oldPassword = value;
                  });
                },
              ),
              TextFormField(
                //input field for new password
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  labelText: "ChangePassword.newPassword".tr(),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  //validate to give feedback if empty or less than 6 characters
                  if (value == null || value.isEmpty) {
                    return "ChangePassword.pleaseNew".tr();
                  } else if (value.trim().length < 6) {
                    return "SignUp.passwordError".tr();
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _newPassword = value;
                  });
                },
              ),
              TextFormField(
                //Input field for Confirm new Password
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  labelText: "ChangePassword.confirmPassword".tr(),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value != _newPassword) {
                    //validate that Confirm New password equals New Password to lessen chance of user having typos in their new password
                    return "ChangePassword.noMatch".tr();
                  }
                  return null;
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
                    await changePassword();
                  }
                },
                child: Text(
                  "ChangePassword.changePassword".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //**
  // Method for changing user password
  //
  // Gets email from auth
  // Gets new password from form which has been validated
  // Changes password and gives user feedback using EasyLoading popup messages
  //
  // */

  Future<void> changePassword() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: _oldPassword);
        EasyLoading.show(status: 'loading...');
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(_newPassword);
        EasyLoading.dismiss();
        EasyLoading.showSuccess("ChangePassword.changeSuccess".tr());
        Navigator.of(context).pop();
      } else {
        EasyLoading.showError('User not found');
      }
    } on FirebaseAuthException catch (error) {
      EasyLoading.showError(error.message ?? 'Password change failed');
    }
  }
}
