import 'package:audifie_version_1/features/authentication/data/models/forgot_password_info_model.dart';
import 'package:audifie_version_1/features/authentication/data/models/sign_in_info_model.dart';
import 'package:audifie_version_1/features/authentication/data/models/sign_up_info_model.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/forgot_password_info.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_in_info.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';

class AuthRepoImplUtil {
  static SignUpInfoModel signUpInfoToModel(SignUpInfo signUpInfo) {
    return SignUpInfoModel(
      name: signUpInfo.name,
      email: signUpInfo.email,
      password: signUpInfo.password,
      configmPassword: signUpInfo.configmPassword,
    );
  }

  static SignInInfoModel signInInfoToModel(SignInInfo signInInfo) {
    return SignInInfoModel(
      email: signInInfo.email,
      password: signInInfo.password,
    );
  }

  static ForgotPasswordInfoModel forgotPasswordInfoToModel(
      ForgotPasswordInfo forgotPasswordInfo) {
    return ForgotPasswordInfoModel(
      email: forgotPasswordInfo.email,
    );
  }
}
