import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/screens/login/login_screen.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_view.dart';
import 'package:weathershare/screens/homescreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weathershare/utils/storage/storage.dart';
//import 'package:weathershare/utils/storage/storage.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final deviceStorage = GetStorage();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;

  /// Getters
  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => _firebaseUser.value?.uid ?? "";

  String get getUserEmail => _firebaseUser.value?.email ?? "";

  String get getDisplayName => _firebaseUser.value?.displayName ?? "";

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    screenRedirect(_firebaseUser.value);
  }

  screenRedirect(User? user) async {
    if (kDebugMode) {
      print("-- get storage --");
      var isFirstTime = deviceStorage.read('IsFirstTime');
      print(isFirstTime);
    }

    if (user != null) {
      // User is logged in
      if (user.emailVerified) {
        await LocalStorage.init(user.uid);
        Get.offAll(() => const HomeScreen());
      }
    } else {
      // User is not logged in or doesn't exist
      deviceStorage.writeIfNull('IsFirstTime', true);
      var isFirstTime = deviceStorage.read('IsFirstTime');
      print(isFirstTime); // Optional: for debugging purposes

      // Check if it's not the first time and redirect accordingly
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingView());
    }
  }

  //Sign up
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw 'Something wrong with Authentication. Please try again';
    } on FirebaseException catch (e) {
      throw 'An unknown Firebase error occurred. Please try again';
    } on FormatException catch (_) {
      throw 'The email address format is invalid. Please enter a valid email.';
    } on PlatformException catch (e) {
      throw 'An unexpected platform error occurred. Please try again.';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //Login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Assuming you want to navigate to the HomeScreen upon successful login
    } on FirebaseAuthException catch (e) {
      throw 'Something wrong with Authentication. Please try again';
    } on FirebaseException catch (e) {
      throw 'An unknown Firebase error occurred. Please try again';
    } on FormatException catch (_) {
      throw 'The email address format is invalid. Please enter a valid email.';
    } on PlatformException catch (e) {
      throw 'An unexpected platform error occurred. Please try again.';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> logout() async => await _auth.signOut();
}