import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _oldPassword = '';
  String _newPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                decoration: const InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
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
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
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
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                decoration:
                    const InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
                validator: (value) {
                  if (value != _newPassword) {
                    return 'Passwords do not match';
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
                    // Perform password change logic
                    await changePassword();
                  }
                },
                child: Text(
                  'Change Password',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
        EasyLoading.showSuccess('Password changed successfully');
        Navigator.of(context).pop();
      } else {
        EasyLoading.showError('User not found');
      }
    } on FirebaseAuthException catch (error) {
      EasyLoading.showError(error.message ?? 'Password change failed');
    }
  }
}
