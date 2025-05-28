import 'package:flutter/material.dart';
import 'package:hubaix/features/auth/services/auth_service.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/user_profile_model.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/repo/home_repositoy.dart';
import 'package:hubaix/utils/utils.dart';

class EditProfileDialog extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfileDialog({
    super.key,
    required this.userProfile,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService authService =
      AuthenticationService(); // Assuming you have a singleton instance

  @override
  void initState() {
    super.initState();
    _phoneController =
        TextEditingController(text: widget.userProfile.phoneNumber);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() async {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                widget.userProfile.phoneNumber = _phoneController.text;
              });

              await HomeRepositoryHttp().updateUserProfile(widget.userProfile);

              if (mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);

                Utils.showSnackBar(context, 'Profile updated successfully');
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
