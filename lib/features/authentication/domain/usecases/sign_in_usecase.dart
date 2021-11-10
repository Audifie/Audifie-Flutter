import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/global/domain/entities/user_info.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_in_info.dart';
import 'package:audifie_version_1/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignInUsecase {
  final AuthRepo _authRepo = sl<AuthRepo>();

  Future<Either<Failure, UserInfo>> getCurrentUser() {
    return _authRepo.getCurrentUser();
  }

  Future<Either<Failure, Success>> signIn(SignInInfo signInInfo) {
    return _authRepo.signInAndStoreAccessToken(signInInfo);
  } 
  Future<Either<Failure, Success>> googleSignIn() {
    return _authRepo.googleSignInAndStoreAccessToken();
  } 
  Future<Either<Failure, Success>> facebookSignIn() {
    return _authRepo.facebookSignInAndStoreAccessToken();
  } 
}