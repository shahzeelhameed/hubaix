import 'package:flutter/material.dart';
import 'package:hubaix/utils/styles.dart';
import 'package:hubaix/utils/validations.dart';

class PasswordDialog extends StatelessWidget {
  PasswordDialog({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text(
        'Reset Password',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter your email address to receive password reset instructions.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            decoration: Styles.buildInputDecoration('Email'),
            keyboardType: TextInputType.emailAddress,
            validator: Validations.validateEmail,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (emailController.text.isNotEmpty) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Password reset instructions sent to your email'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}
