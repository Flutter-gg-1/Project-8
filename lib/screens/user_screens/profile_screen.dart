import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
import 'package:project8/widgets/cards/profile_card.dart';
import 'package:project8/widgets/texts/category_title.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = GetIt.I.get<AuthLayer>().customer;
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 53,
                        child: Image.asset(
                            "assets/images/default_profile_img.png",
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Take a coffee & give me\n something",
                            style: TextStyle(
                                color: AppConstants.subTextColor,
                                fontFamily: "Average",
                                fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const CategoryTitle(title: "Information"),
                ProfileCard(title: profile!.name, icon: Icons.person_outline),
                ProfileCard(
                    title: profile.email, icon: Icons.mail_outline_outlined),
                ProfileCard(
                    title: profile.phoneNumber, icon: Icons.phone_outlined),
                const SizedBox(height: 20),
                const CategoryTitle(title: "Settings"),
                ProfileCard(
                    title: "Contact us",
                    icon: Icons.link,
                    onTap: () async {
                      if (!await launchUrl(
                          Uri.parse("https://linktr.ee/Onzecafe11"))) {
                        throw Exception('Could not launch link');
                      }
                    }),
                const ProfileCard(
                    title: "Q&A", icon: Icons.question_answer_outlined),
                const ProfileCard(title: "Dark mode", icon: Icons.dark_mode),
                TextButton.icon(
                  label: const Text("Logout",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Average",
                          color: AppConstants.mainRed)),
                  icon: const Icon(Icons.power_settings_new,
                      color: AppConstants.mainRed, size: 30),
                  style: const ButtonStyle(
                      overlayColor: WidgetStateColor.transparent,
                      padding: WidgetStatePropertyAll(EdgeInsets.only(top: 8))),
                  onPressed: () {
                    log("bye bye");
                    GetIt.I.get<AuthLayer>().customer = null;
                    GetIt.I.get<AuthLayer>().box.erase();
                    log("box now is empty");
                    context.pushRemove(screen: const LoginScreen());
                  },
                ),
                SizedBox(height: 70)
              ],
            ),
          ),
        ),
      ),
    );
  }
}