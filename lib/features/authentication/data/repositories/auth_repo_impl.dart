import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/global/domain/entities/user_info.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/utils/auth_repo_impl_util.dart';
import 'package:audifie_version_1/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:audifie_version_1/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:audifie_version_1/features/authentication/data/models/sign_in_info_model.dart';
import 'package:audifie_version_1/features/authentication/data/models/sign_up_info_model.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_in_info.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/forgot_password_info.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource = sl<AuthRemoteDataSource>();
  final AuthLocalDataSource _authLocalDataSource = sl<AuthLocalDataSource>();

  @override
  Future<Either<Failure, UserInfo>> getCurrentUser() async {
    try {
      final String accessToken = await _authLocalDataSource.getAccessToken();
      _authRemoteDataSource.setAccessTokenAsCookieGlobally(accessToken);
      final UserInfo? user =
          await _authRemoteDataSource.getCurrentUser();
      if (user != null) {
        return Right(user);
      }
      await _authLocalDataSource.deleteAccessToken();
      return Left(SignInFailure(message: 'User not logged in'));
    } on ReadException catch (e) {
      return Left(
          ReadFailure(message: 'There was some error. Please try again'));
    } on DioError catch (e) {
      return Left(
          SignInFailure(message: 'There was some error. Please try again'));
    }
  }

  @override
  Future<Either<Failure, Success>> sendOtpForSignUp(
      SignUpInfo signUpInfo) async {
    try {
      final SignUpInfoModel signUpInfoModel =
          AuthRepoImplUtil.signUpInfoToModel(signUpInfo);
      await _authRemoteDataSource.sendOptForSignUp(signUpInfoModel);
      return Right(
          SignUpSuccess(message: Strings.otpSent + '. ' + Strings.enterOtp));
    } on SignUpException catch (e) {
      return Left(SignUpFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Success>> verifyOtpAndSignUpAndStoreAccessToken(
      SignUpInfo signUpInfo, String otp) async {
    String? accessToken;
    try {
      await _authRemoteDataSource.verifyOtpAndSignUp(signUpInfo.email, otp);
      final SignInInfoModel signInInfoModel = SignInInfoModel(
        email: signUpInfo.email,
        password: signUpInfo.password,
      );
      accessToken = await _authRemoteDataSource.signIn(signInInfoModel);
      await _authLocalDataSource.storeAccessToken(accessToken);
      return Right(SignUpSuccess(message: Strings.signUpSuccess));
    } on SignUpException catch (e) {
      return Left(SignUpFailure(message: e.message));
    } on WriteException catch (e) {
      await _authLocalDataSource.storeAccessToken(accessToken!);
      return Left(WriteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Success>> googleSignUp() async {
    try {
      await _authRemoteDataSource.googleSignUp();
      return Right(SignUpSuccess(message: Strings.signUpSuccess));
    } on SignUpException catch (e) {
      return Left(SignUpFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Success>> facebookSignUp() async {
    try {
      await _authRemoteDataSource.facebookSignUp();
      return Right(SignUpSuccess(message: Strings.signUpSuccess));
    } on SignUpException catch (e) {
      return Left(SignUpFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Success>> signInAndStoreAccessToken(
      SignInInfo signInInfo) async {
    try {
      final SignInInfoModel signInInfoModel =
          AuthRepoImplUtil.signInInfoToModel(signInInfo);
      final String accessToken =
          await _authRemoteDataSource.signIn(signInInfoModel);
      await _authLocalDataSource.storeAccessToken(accessToken);

      return Right(SignInSuccess(message: Strings.signInSuccess));
    } on SignInException catch (e) {
      return Left(SignInFailure(message: e.message));
    } on WriteException catch (e) {
      return Left(
          WriteFailure(message: 'There was some problem. Please try again'));
    }
  }

  @override
  Future<Either<Failure, Success>> googleSignInAndStoreAccessToken() async {
    try {
      final String accessToken = await _authRemoteDataSource.googleSignIn();
      await _authLocalDataSource.storeAccessToken(accessToken);

      return Right(SignInSuccess(message: Strings.signInSuccess));
    } on SignInException catch (e) {
      return Left(SignInFailure(message: e.message));
    } on WriteException catch (e) {
      return Left(
          SignInFailure(message: 'There was some problem. Please try again'));
    }
  }

  @override
  Future<Either<Failure, Success>> facebookSignInAndStoreAccessToken() async {
    try {
      await _authRemoteDataSource.facebookSignIn();
      return Right(SignInSuccess(message: Strings.signInSuccess));
    } on SignInException catch (e) {
      return Left(SignInFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Success>> forgotPassword(
      ForgotPasswordInfo forgotPasswordInfo) async {
    // TODO: Unimplemented error
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Success>> signOut() async {
    try {
      await _authRemoteDataSource.logout();
      await _authLocalDataSource.deleteAccessToken();
      return Right(SignOutSuccess(message: 'Successfully signed out'));
    } on SignOutException catch (e) {
      return Left(SignOutFailure(message: e.message));
    } on WriteException catch (e) {
      return Left(SignOutFailure(message: 'Failed to sign out'));
    }
  }
}
