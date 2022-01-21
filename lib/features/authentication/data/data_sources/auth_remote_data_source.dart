import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/global/data/models/user_info_model.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/authentication/data/models/forgot_password_info_model.dart';
import 'package:audifie_version_1/features/authentication/data/models/sign_in_info_model.dart';
import 'package:audifie_version_1/features/authentication/data/models/sign_up_info_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

abstract class AuthRemoteDataSource {
  void setAccessTokenAsCookieGlobally(String accessToken);
  Future<UserInfoModel?> getCurrentUser();

  Future<void> sendOptForSignUp(SignUpInfoModel signUpInfoModel);
  Future<void> verifyOtpAndSignUp(String email, String otp);
  Future<void> googleSignUp();
  Future<void> facebookSignUp();

  Future<String> signIn(SignInInfoModel signInInfoModel);
  Future<String> googleSignIn();
  Future<String> facebookSignIn();

  Future<void> forgotPassword(ForgotPasswordInfoModel forgotPasswordInfoModel);

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio = sl<Dio>();
  // final GoogleSignIn _googleSignIn = sl<GoogleSignIn>();

  @override
  void setAccessTokenAsCookieGlobally(String accessToken) {
    _dio.options.headers = {
      'cookie': accessToken,
    };
  }

  @override
  Future<UserInfoModel?> getCurrentUser() async {
    try {
      final Response response = await _dio.get(
        Strings.apiCurrentUser,
        // options: Options(
        //   headers: {
        //     'cookie': accessToken,
        //   },
        // ),
      );
      if (response.statusCode == 200) {
        if (response.data['user'] != null) {
          return UserInfoModel.fromMap(response.data['user']);
        }
      }
      return null;
    } on DioError catch (e) {
      print('message: ' + e.response?.data['message']);
      print(
          'Error in [AuthRemoteDataSourceImpl] [currentUser] [DioError]: ${e.message}');
      return null;
    }
  }

  @override
  Future<void> sendOptForSignUp(SignUpInfoModel signUpInfoModel) async {
    try {
      final Response response = await _dio.post(
        Strings.apiSignUp,
        data: {
          'email': signUpInfoModel.email,
          'name': signUpInfoModel.name,
          'password': signUpInfoModel.password,
          'confirmPassword': signUpInfoModel.configmPassword,
        },
      );
      if (response.statusCode != 200) {
        if (response.data['message'] != null) {
          throw SignUpException(message: response.data['message']!);
        }
        throw SignUpException(
            message: 'There was some error. Please try again');
      }
    } on SignUpException catch (e) {
      print(
          'Error in [AuthRemoteDataSourceImpl] [sendOptForSignUp]: ${e.message}');
      throw e;
    } on DioError catch (e) {
      print(
          'Error in [AuthRemoteDataSourceImpl] [sendOptForSignUp]: ${e.message}');
      final String? message =
          e.response != null ? e.response!.data['message'] : null;
      throw SignUpException(
          message: message ?? 'There was some error. Please try again');
    }
  }

  @override
  Future<void> verifyOtpAndSignUp(String email, String otp) async {
    try {
      final Response response = await _dio.post(
        Strings.apiVerifyEmail,
        data: {
          'email': email,
          'verificationCode': otp,
        },
      );
      if (response.statusCode != 200) {
        if (response.data['message'] != null) {
          throw SignUpException(message: response.data['message']);
        }
        throw SignUpException(
            message: 'There was some error. Please try again');
      }
    } on SignUpException catch (e) {
      print(
          'Error in [AuthRemoteDataSourceImpl] [verifyOtpAndSignUp]: ${e.message}');
      throw e;
    } on DioError catch (e) {
      print(
          'Error in [AuthRemoteDataSourceImpl] [verifyOtpAndSignUp]: ${e.message}');
      final String? message =
          e.response != null ? e.response!.data['message'] : null;
      throw SignUpException(
          message: message ?? 'There was some error. Please try again');
    }
  }

  @override
  Future<void> googleSignUp() {
    // TODO: implement googleSignUp
    throw UnimplementedError();
  }

  @override
  Future<void> facebookSignUp() {
    // TODO: implement facebookSignUp
    throw UnimplementedError();
  }

  @override
  Future<String> signIn(SignInInfoModel signInInfoModel) async {
    try {
      final Response response = await _dio.post(
        Strings.apiLogin,
        data: {
          'email': signInInfoModel.email,
          'password': signInInfoModel.password,
        },
      );
      if (response.statusCode == 200) {
        final String? accessToken = response.headers['set-cookie']?[0];
        if (accessToken != null) {
          setAccessTokenAsCookieGlobally(accessToken);
          return accessToken;
        }
        throw SignInException(message: 'Access token was null');
      }
      if (response.data['message'] != null) {
        throw SignInException(message: response.data['message']);
      }
      throw SignInException(message: 'There was some error. Please try again');
    } on SignInException catch (e) {
      print('Error in [AuthRemoteDataSourceImpl] [signIn]: ${e.message}');
      throw e;
    } on DioError catch (e) {
      print('Error in [AuthRemoteDataSourceImpl] [signIn]: ${e.message}');
      final String? message =
          e.response != null ? e.response!.data['message'] : null;
      throw SignInException(
          message: message ?? 'There was some error. Please try again');
    }
  }

  @override
  Future<String> googleSignIn() async {
    // GoogleSignInAccount? googleAccount;
    try {
      //   final GoogleSignInAccount? currentUser = _googleSignIn.currentUser;
      //   print('Current user: $currentUser');

      //   if (currentUser != null) {
      //     await _googleSignIn.disconnect();
      //     // googleAccount = _googleSignIn.currentUser;
      //   }
      //   // else {
      //   googleAccount = await _googleSignIn.signIn();
      //   // }
      //   if (googleAccount != null) {
      //     final GoogleSignInAuthentication googleSignInAuthentication =
      //         await googleAccount.authentication;

      //     final String? code = googleSignInAuthentication.idToken;
      //     print('Code: $code');
      //     if (code != null) {
      //       final Response response = await _dio.post(
      //         Strings.apiGoogleLogin,
      //         data: {
      //           'code': code,
      //         },
      //       );
      //     }

      // if (response.statusCode == 200) {
      //   if (response.data['token'] != null) {
      //     // return response.data['token'];
      //   }
      //   throw SignInException(message: 'Access token was null');
      // } else {
      //   if (response.data['message'] != null) {
      //     throw SignInException(message: response.data['message']);
      //   }
      // }

      throw SignInException(message: 'There was some error. Please try again');
    } on SignInException catch (e) {
      print(
          'Error in [AuthRemoteDataSourceImpl] [googleSignIn] [SignInException]: ${e.message}');
      rethrow;
    } on DioError catch (e) {
      print(
          'Error in [AuthRemoteDataSourceImpl] [googleSignIn] [DioError]: ${e.error}');
      final message = e.response!.data['message'];
      print('Msg: $message');
      throw SignInException(message: '');
    } on PlatformException catch (e) {
      print('Message: ${e.message}');
      print('Code: ${e.code}');
      print('Details: ${e.details}');
      throw SignInException(message: '');
    } catch (e) {
      print('Error in [AuthRemoteDataSourceImpl] [googleSignIn]: $e');
      throw SignInException(message: 'There was some error. Please try again');
    }
  }

  @override
  Future<String> facebookSignIn() async {
    try {
      // final AccessToken? accessToken = await _facebookAuth.accessToken;
      // if (accessToken != null) {
      //   print('Facebook access token from user: ${accessToken.token}');
      //   throw SignInException(
      //       message: 'There was some error. Please try again');
      // } else {
      //   final LoginResult loginResult = await _facebookAuth.login();
      //   print('Facebook access token: ${loginResult.accessToken.toString()}');
      //   throw SignInException(
      //       message: 'There was some error. Please try again');
      // }

      // final LoginResult loginResult = await _facebookAuth.login();
      // print('Facebook access token: ${loginResult.accessToken.toString()}');
      throw SignInException(message: 'There was some error. Please try again');
    } catch (e) {
      throw SignInException(message: 'There was some error. Please try again');
    }
  }

  @override
  Future<void> forgotPassword(ForgotPasswordInfoModel forgotPasswordInfoModel) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    try {
      final Response response = await _dio.post(
        Strings.apiLogout,
        // options: Options(
        //   headers: {
        //     'cookie': accessToken,
        //   },
        // ),
      );
      if (response.statusCode != 200) {
        print(
            'Error in [AuthRemoteDataSourceImpl] [logout]: status code not 200');
        throw SignOutException(
            message: 'There was an error in signing out. Please try again');
      }
    } on SignOutException {
      print(
          'Error in [AuthRemoteDataSourceImpl] [logout]: status code not 200');

      rethrow;
    } catch (e) {
      print('Error in [AuthRemoteDataSourceImpl] [logout]: $e');
      throw SignOutException(
          message: 'There was an error in signing out. Please try again');
    }
  }
}
