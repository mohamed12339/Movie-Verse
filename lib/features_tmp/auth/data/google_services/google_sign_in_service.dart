import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoogleSignInService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;

  GoogleSignInService({GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth})
    : _googleSignIn = googleSignIn ?? GoogleSignIn(),
      _auth = firebaseAuth ?? FirebaseAuth.instance;

  Future<String?> signInAndGetIdToken({bool forceAccountPicker = true}) async {
    if (forceAccountPicker) {
      // امسح آخر اختيار عشان يظهر الـ account picker
      try {
        await _googleSignIn.signOut();
      } catch (_) {}
      // لو حابب إجبار أقوى (يلغي التفويض بالكامل):
      // try { await _googleSignIn.disconnect(); } catch (_) {}
    }

    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    final googleAuth = await account.authentication;
    if (googleAuth.idToken == null) throw Exception('NO_ID_TOKEN');

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final userCred = await _auth.signInWithCredential(credential);
    final user = userCred.user;
    if (user == null) return null;

    return await user.getIdToken();
  }

  /// خروج: signOut يمسح الجلسة، disconnect يلغي التفويض (ويضمن ظهور اختيار الإيميل)
  Future<void> signOut({bool revokeAccess = true}) async {
    await _auth.signOut();
    try {
      if (revokeAccess) {
        await _googleSignIn.disconnect(); // يضمن ظهور picker في المرة الجاية
      } else {
        await _googleSignIn.signOut();
      }
    } catch (_) {}
  }
}
