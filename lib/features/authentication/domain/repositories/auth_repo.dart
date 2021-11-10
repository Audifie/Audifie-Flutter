import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/global/domain/entities/user_info.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/forgot_password_info.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_in_info.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserInfo>> getCurrentUser();

  Future<Either<Failure, Success>> sendOtpForSignUp(SignUpInfo signUpInfo);
  Future<Either<Failure, Success>> verifyOtpAndSignUpAndStoreAccessToken(SignUpInfo signUpInfo, String otp);
  Future<Either<Failure, Success>> googleSignUp();
  Future<Either<Failure, Success>> facebookSignUp();

  Future<Either<Failure, Success>> signInAndStoreAccessToken(SignInInfo signInInfo);
  Future<Either<Failure, Success>> googleSignInAndStoreAccessToken();
  Future<Either<Failure, Success>> facebookSignInAndStoreAccessToken();

  Future<Either<Failure, Success>> forgotPassword(ForgotPasswordInfo forgotPasswordInfo);

  Future<Either<Failure, Success>> signOut();
}