import 'package:hubaix/features/auth/services/auth_service.dart';

abstract class AuthRepo {
  Future<bool> signUp({
    required String username,
    required String email,
    required String password,
    required String cnic,
    required String phone,
  });

  Future<bool> login({
    required String email,
    required String password,
  });
}

class AuthRepoHttp implements AuthRepo {
  AuthenticationService authenticationService = AuthenticationService();
  @override
  Future<bool> signUp(
      {required String username,
      required String email,
      required String password,
      required String cnic,
      required String phone}) async {
    final response = await authenticationService.signUp(
        username: username,
        email: email,
        password: password,
        cnic: cnic,
        phone: phone);

    print(response);

    return response;
  }

  @override
  Future<bool> login({required String email, required String password}) async {
    final response =
        await authenticationService.login(email: email, password: password);

    print(response);

    return response;
  }
}
