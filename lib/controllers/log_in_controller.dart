import 'package:assignment0/services/google_sign_in_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class LogInController {
  UserCredential? userCredential;

  final locator = GetIt.instance;

  Future<UserCredential?> loginUser() async {
    userCredential = await locator.get<GoogleAuthService>().googleSignIn();
    return userCredential;
  }

  Future<void> logoutUser() async{
    await locator.get<GoogleAuthService>().signOut();
  }
}
