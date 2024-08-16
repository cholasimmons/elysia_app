import 'package:elysia_app/constants/constants.dart';
import 'package:elysia_app/models/auth_model.dart';
import 'package:elysia_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage(this.authProvider, {super.key});

  final AuthProvider authProvider;

  final String title = 'Login';

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final bool _rememberMe = false;

  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

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
            key: _formKeyLogin,
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
                  keyboardType: TextInputType.text
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                ElevatedButton.icon(
                    icon: authProvider.isLoggingIn ?
                    const SizedBox(
                        width: 20, // Set the desired width
                        height: 20, // Set the desired height
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                        )
                    )
                        :
                    const Icon(Icons.lock_open),
                    label: const Text('Login'),
                    onPressed: (){
                      Login login = Login(_emailCtrl.text, _passwordCtrl.text, _rememberMe);
                      authProvider.isLoggingIn || _emailCtrl.text.length < 8 || _passwordCtrl.text.length < 8 ?
                          null :
                          authProvider.login(login);
                }),
                const SizedBox(height: AppConstants.defaultPadding),
                GestureDetector(
                  onTap: authProvider.goToSignup,
                  child: const Text('Create an Account', textAlign: TextAlign.center, style: TextStyle(decoration: TextDecoration.underline),),


                )
              ],
            ),
          )
      ),
    );
  }
}
