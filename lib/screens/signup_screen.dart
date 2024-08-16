import 'package:elysia_app/constants/constants.dart';
import 'package:elysia_app/models/auth_model.dart';
import 'package:elysia_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage(this.authProvider, {super.key});

  final AuthProvider authProvider;

  final String title = 'Signup';

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _password2Ctrl = TextEditingController();
  final TextEditingController _firstnameCtrl = TextEditingController();
  final TextEditingController _lastnameCtrl = TextEditingController();

  final GlobalKey<FormState> _formKeySignup = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(
              top: AppConstants.defaultPadding,
              left: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppConstants.defaultPadding
          ),
          child: Form(
            key: _formKeySignup,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.defaultPadding),
                Center(child: Text(title, style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: Colors.purpleAccent),),),
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress, // For email input
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordCtrl,
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                TextField(
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  controller: _password2Ctrl,
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                TextField(
                  decoration: const InputDecoration(labelText: 'First Name'),
                  controller: _firstnameCtrl,
                  keyboardType: TextInputType.name
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                TextField(
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  controller: _lastnameCtrl,
                  keyboardType: TextInputType.name
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                ElevatedButton.icon(
                    icon: authProvider.isRegistering
                        ? const SizedBox(
                            width: 20, // Set the desired width
                            height: 20, // Set the desired height
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                            )
                        )
                        : const Icon(Icons.lock_open),
                    onPressed: (){
                      Signup signup = Signup(_emailCtrl.text, _passwordCtrl.text, _password2Ctrl.text, _firstnameCtrl.text, _lastnameCtrl.text);
                      authProvider.isRegistering || _emailCtrl.value.text.length < 8 || _passwordCtrl.text.length < 8 || (_passwordCtrl.text != _password2Ctrl.text) ?
                      null :
                      authProvider.register(signup);
                    }, label: const Text('Create Account')),
                const SizedBox(height: AppConstants.defaultPadding),
                GestureDetector(
                  onTap: authProvider.goToLogin,
                  child: const Text('Already have an Account? Log In', textAlign: TextAlign.center, style: TextStyle(decoration: TextDecoration.underline),),
                ),
                const SizedBox(height: AppConstants.defaultPadding*2),
              ],
            ),
          )
      ),
    );
  }
}