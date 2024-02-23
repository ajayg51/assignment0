import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenController extends GetxController {
  UserCredential? userCredential;

  final error = "Error".obs;
  final isLoading = true.obs;

  @override
  void onReady() async {
    super.onReady();
    await googleSignIn();
    // Get.off(HomeScreen(
    //   msg: error,
    // ));
    // if (FirebaseAuth.instance.currentUser != null) {
    //   Get.off(HomeScreen(msg: error,));
    // } else {
    //   await googleSignIn();
    //   Get.off(HomeScreen(msg: error,));
    // }
  }

  Future<void> googleSignIn() async {
    error.value += " :: start";
    update();

    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    try {
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      error.value += "  :: here 1";
      update();

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      error.value +=  "${userCredential?.user.toString()} :: ERR :: ";

    } catch (e) {
      error.value += " :: here 2 $e";
      update();
    } finally {
      isLoading.value = false;
      error.value += "     :: ending";
      update();
    }
  }
}
