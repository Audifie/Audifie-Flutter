import 'package:audifie_version_1/core/global/domain/entities/user_info.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_in_info.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';
import 'package:audifie_version_1/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:audifie_version_1/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:audifie_version_1/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:audifie_version_1/features/authentication/presenter/pages/otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  final SignUpUsecase _signUpUsecase = SignUpUsecase();
  final SignInUsecase _signInUsecase = SignInUsecase();
  final SignOutUsecase _signOutUsecase = SignOutUsecase();

  bool _isLoading = false;
  bool _isAuthDone = false;
  UserInfo? _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthDone => _isAuthDone;
  UserInfo? get currentUser => _currentUser;

  Future<UserInfo?> getCurrentUser() async {
    _isLoading = true;

    await _signInUsecase.getCurrentUser()
      ..fold((l) {
        _isAuthDone = false;
      }, (r) {
        _currentUser = r;
        _isAuthDone = true;
      });

    _isLoading = false;
    notifyListeners();
  }

  void sendOtpForSignUp(BuildContext context, SignUpInfo signUpInfo) async {
    _isLoading = true;
    notifyListeners();

    await _signUpUsecase.sendOtpForSignUp(signUpInfo)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        Navigator.pushNamed(context, OtpPage.routeName, arguments: signUpInfo);
      });

    _isLoading = false;
    notifyListeners();
  }

  void verifyOtpAndSignUp(
      BuildContext context, SignUpInfo signUpInfo, String otp) async {
    _isLoading = true;
    notifyListeners();

    await _signUpUsecase.verifyOtpAndSignUp(signUpInfo, otp)
      ..fold((l) {
        ScaffoldMessenger.of(context).showSnackBar(Snackbar(message: l.message));
      }, (r) {
        Navigator.pop(context);
        _isAuthDone = true;
      });

    _isLoading = false;
    notifyListeners();
  }

  void signIn(BuildContext context, SignInInfo signInInfo) async {
    _isLoading = true;
    notifyListeners();

    await _signInUsecase.signIn(signInInfo)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        _isAuthDone = true;
      });

    _isLoading = false;
    notifyListeners();
  }

  void googleSignIn(BuildContext context) async {
    _showCommingSoon(context);
  }

  void facebookSignIn(BuildContext context) async {
    _showCommingSoon(context);

    // _isLoading = true;
    // notifyListeners();

    // await _signInUsecase.facebookSignIn()
    //   ..fold((l) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(Snackbar(message: l.message));
    //   }, (r) {
    //     _isAuthDone = true;
    //   });

    // _isLoading = false;
    // notifyListeners();
  }

  void forgotPassword(BuildContext context) async {
    _showCommingSoon(context);
  }

  void signOut(BuildContext context) async {
    await _signOutUsecase.signOut()
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        _isAuthDone = false;
      });

    notifyListeners();
  }

  void _showCommingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(Snackbar(message: 'Comming soon!',));
  }
}
