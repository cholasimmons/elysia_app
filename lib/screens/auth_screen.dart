import 'package:elysia_app/providers/auth_provider.dart';
import 'package:elysia_app/screens/login_screen.dart';
import 'package:elysia_app/screens/signup_screen.dart';
import 'package:elysia_app/theme/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title = 'Authentication';

  @override
  Widget build(BuildContext context) {
    // final toastService = Provider.of<ToastService>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context);
    // final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!authProvider.isLoggingIn && !authProvider.isRegistering && authProvider.isLeaving) {
        Navigator.of(context).pop();
        // _showSuccessModal(context, connectProvider);
        // connectProvider.resetConnectionState(); // Reset after showing the modal
      }
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTheme.darkTheme.scaffoldBackgroundColor,
          titleTextStyle: const TextStyle(color: Colors.grey, fontSize: 20),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title, textAlign: TextAlign.center,),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: PageView(
            controller: authProvider.pageController,
            onPageChanged: (index) => authProvider.setCurrentPage(index),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              LoginPage(authProvider),
              SignupPage(authProvider)
            ]
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}