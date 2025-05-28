import 'package:flutter/material.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/widget/profile_option_sheet.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/widget/search_dialog_widget.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/user_profile_model.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/repo/home_repositoy.dart';
import 'package:hubaix/utils/utils.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile>(
      future: HomeRepositoryHttp().getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Error loading profile"),
          );
        } else if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No user data"),
          );
        }

        final userProfile = snapshot.data!;

        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Utils.showBottomSheet2(
                    context, ProfileOptionSheet(userProfile: userProfile)),
                child: const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.person),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfile.username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userProfile.email,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(icon: const Icon(Icons.search), onPressed: onPressed),
            ],
          ),
        );
      },
    );
  }
}
