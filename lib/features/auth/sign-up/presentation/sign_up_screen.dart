import 'package:flutter/material.dart';
import 'package:hubaix/features/auth/login/presentation/login_screen.dart';
import 'package:hubaix/features/auth/repository/auth_repo.dart';
import 'package:hubaix/utils/styles.dart';
import 'package:hubaix/utils/utils.dart';
import 'package:hubaix/utils/validations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cnicController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create an account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: Styles.buildInputDecoration('Username'),
                validator: Validations.validateUsername,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _cnicController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                maxLength: 13,
                decoration: Styles.buildInputDecoration('CNIC'),
                validator: Validations.validateCNIC,
                onChanged: (value) {
                  final formattedValue = Validations.formatCNIC(value);
                  if (value != formattedValue) {
                    _cnicController.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                          offset: formattedValue.length),
                    );
                  }
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: Styles.buildInputDecoration('Email'),
                validator: Validations.validateEmail,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                decoration: Styles.buildInputDecoration('Phone'),
                validator: Validations.validatePhone,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: _obscureText,
                decoration: Styles.buildInputDecoration('Password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  ),
                  helperText: 'Must contain uppercase, lowercase, and numbers',
                  helperStyle: const TextStyle(color: Colors.grey),
                ),
                validator: Validations.validatePassword,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () =>
                      Utils.showBottomSheet(context, const LoginModal()),
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final response = await AuthRepoHttp().signUp(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          cnic: _cnicController.text,
          phone: _phoneController.text);

      if (response == true) {
        Utils.showSnackBar(context, "User created Succesfully");
        Future.delayed(
          Durations.medium2,
          () => Utils.showBottomSheet(context, const LoginModal()),
        );
      } else {
        Utils.showSnackBar(
            context, "User already exists or some other error occured");
        setState(() => _isLoading = false);
        return;
      }

      setState(() {
        _isLoading = false;
        _formKey.currentState!.reset();
      });
    }
  }
}
