import 'package:flutter/material.dart';
import 'package:hubaix/config/components/profile_option_title.dart';
import 'package:hubaix/features/auth/sign-up/presentation/sign_up_screen.dart';
import 'package:hubaix/features/bookmark_news/presentation/bookmarked_news_page.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/widget/edit_profile_dialog.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/user_profile_model.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/repo/home_repositoy.dart';
import 'package:hubaix/features/my_complains/presentation/my_complains_screen.dart';
import 'package:hubaix/features/welcome/presentation/welcome_screen.dart';
import 'package:hubaix/utils/utils.dart';

class ProfileOptionSheet extends StatelessWidget {
  const ProfileOptionSheet({super.key, required this.userProfile});

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          ProfileOptionTile(
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () {
              Utils.showDialogBox(
                  context,
                  EditProfileDialog(
                    userProfile: userProfile,
                  ));
            },
          ),
          ProfileOptionTile(
            icon: Icons.list_alt,
            title: 'My Complaints',
            onTap: () {
              Utils.push(context, const MyComplainsScreen());
            },
          ),
          ProfileOptionTile(
            icon: Icons.bookmark,
            title: 'Bookmarked News',
            onTap: () {
              Utils.push(context, const BookmarkedNewsPage());
            },
          ),
          ProfileOptionTile(
            icon: Icons.logout,
            title: 'Logout',
            isDestructive: true,
            onTap: () async {
              await HomeRepositoryHttp().logout().then(
                (value) {
                  if (value == true) {
                    Utils.pushReplacement(context, const WelcomePage());
                  }
                },
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
