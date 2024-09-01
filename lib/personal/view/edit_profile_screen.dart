import 'package:flutter/material.dart';

import '../model/user.dart';
import '../model/user_preferences.dart';
import 'components/profile_widget.dart';
import 'components/textfield_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User user = UserPreferences().myUser;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: const BackButton(),
      backgroundColor: Colors.grey[200],
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.id,
                  onChanged: (email) {},
                ),
              ],
            ),
          ),
        ),
      );
}
