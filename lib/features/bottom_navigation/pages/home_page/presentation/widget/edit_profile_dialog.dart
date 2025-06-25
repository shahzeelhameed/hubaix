import 'package:flutter/material.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/user_profile_model.dart';
import 'package:hubaix/utils/utils.dart';
import '../../../../../../pages/user_repository.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;
  late TextEditingController _retypePasswordController;
  late TextEditingController _cnicController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.userProfile.username);
    _retypePasswordController = TextEditingController();
    _cnicController = TextEditingController(text: widget.userProfile.cnicNumber);
    _phoneController = TextEditingController(text: widget.userProfile.phoneNumber);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _retypePasswordController.dispose();
    _cnicController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedData = {
      'username': _usernameController.text.trim(),
      'retypepassword': _retypePasswordController.text.trim(),
      'cnic_number': _cnicController.text.trim(),
      'role': 'user', // static role
      'phone': _phoneController.text.trim(),
    };

    try {
      await UserRepository().updateUserProfileById(widget.userProfile.userId, updatedData);

      // Update local user profile fields after success (if you want)
      setState(() {
        widget.userProfile.username = _usernameController.text.trim();
        widget.userProfile.cnicNumber = _cnicController.text.trim();
        widget.userProfile.phoneNumber = _phoneController.text.trim();
      });

      if (mounted) {
        Navigator.of(context).pop();
        Utils.showSnackBar(context, 'Profile updated successfully');
      }
    } catch (e) {
      Utils.showSnackBar(context, 'Failed to update profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Retype Password
              TextFormField(
                controller: _retypePasswordController,
                decoration: const InputDecoration(
                  labelText: 'Retype Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // CNIC Number
              TextFormField(
                controller: _cnicController,
                decoration: const InputDecoration(
                  labelText: 'CNIC Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your CNIC number';
                  }
                  // Basic CNIC format validation (e.g., 42101-1234567-1)
                  if (!RegExp(r'^\d{5}-\d{7}-\d{1}$').hasMatch(value.trim())) {
                    return 'Enter a valid CNIC number (e.g., 42101-1234567-1)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value.trim())) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
