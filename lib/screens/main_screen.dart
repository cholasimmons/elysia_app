import 'package:elysia_app/constants/constants.dart';
import 'package:elysia_app/providers/home_provider.dart';
import 'package:elysia_app/screens/home_screen.dart';
import 'package:elysia_app/screens/profile_screen.dart';
import 'package:elysia_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  final String title = 'Home';

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<HomeProvider>(context);
    // final theme = Theme.of(context);
    final PageController pageController = PageController(initialPage: 0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (_, provider, child){
            return PageView(
            controller: pageController,
            onPageChanged: (index) {
              provider.setCurrentIndex(index);
            },
            physics: const NeverScrollableScrollPhysics(),
            children: const [
               HomePage(),
               ProfilePage(),
               SettingsPage(),
            ],
        );}),
      ),
      bottomNavigationBar: Consumer<HomeProvider>(
        builder: (_, provider, child) {
          return BottomNavigationBar(
            currentIndex: provider.currentIndex,
            onTap: (index) =>
            {
              provider.setCurrentIndex(index),
              pageController.animateToPage(index, duration: const Duration(milliseconds: AppConstants.pageAnimDuration), curve: Curves.easeInOut)
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          );
        }
        ),
    );
  }
}
