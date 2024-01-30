import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late final FirebaseAuth fauth;
  User? curuser;
  late final Rx<User?> userstream;
  var vreifId = ''.obs;

  Future<void> init() async {
    fauth = FirebaseAuth.instance;
    userstream = curuser.obs;
  }

  void listenUserAuthState() {
    FirebaseAuth.instance.authStateChanges().listen(onUserAuthStateChange);
  }

  Future<void> onUserAuthStateChange(User? user) async {
    if (user != null) {
      curuser = user;
      userstream.value = user;
    } else {
      curuser = null;
      userstream.value = null;
    }
    userstream.refresh();
  }

  Future<void> loginByPhone(String phone) async {
    await fauth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (creds) async {
        await fauth.signInWithCredential(creds);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          throw ('THE PROVIDED PHONE NUMBER IS INVALID');
        } else {
          throw ('SOMETHING WENT WRONG');
        }
      },
      codeSent: (id, resendToken) {
        vreifId.value = id;
      },
      codeAutoRetrievalTimeout: (id) {
        vreifId.value = id;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var cred = await fauth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: vreifId.value,
        smsCode: otp,
      ),
    );
    return cred.user != null;
  }
}
